VOID
KiUserExceptionDispatcher(
   __in PCONTEXT ContextRecord,
   __in PEXCEPTION_RECORD ExceptionRecord,
  )
{
   NTSTATUS Status;

   //
   // (A custom calling convention is used that does not pass the parameter
   // values in a C-compatible fashion.)
   //

#if defined(_WIN64)

   //
   // If Wow64.dll has registered its helper function for preprocessing exception
   // events then invoke it here and now.
   //

   if (Wow64PrepareForException)
      Wow64PrepareForException(
         ExceptionRecord,
         ContextRecord
         );

#endif

   if (RtlDispatchException(
         ExceptionRecord,
         ContextRecord))
   {
#if defined(_WIN64)
      RtlRestoreContext( ContextRecord );
#else
      NtContinue(
         ContextRecord,
         FALSE
         );
#endif

      Status = (NTSTATUS)ContextRecord->Rax;

      RtlRaiseStatus( Status );

      //
      // No return from RtlRaiseStatus.
      //

   }

   Status = NtRaiseException(
      ContextRecord,
      ExceptionRecord,
      FALSE
      );

   RtlRaiseStatus( Status );

   //
   // No return from RtlRaiseStatus.
   //
}