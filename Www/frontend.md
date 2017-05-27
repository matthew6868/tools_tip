#html/css/javascript tips

## html

## css
* #### 1, class and id in html
```
'.'
=> used for class in html element
'#'
=> used for id in html element
```

* #### 2, input相关
```
/* 移除默认的边框 */
input{
    background-color: transparent;
    border: 0px;
}

input:focus {/*移除聚焦状态的边框*/
    outline:none
}
/* 设置placehoder的颜色值 */
input::-webkit-input-placeholder, textarea::-webkit-input-placeholder {
        color:#666;
    }
    input:-moz-placeholder, textarea:-moz-placeholder {
        color:#666;
    }
    input::-moz-placeholder, textarea::-moz-placeholder {
        color:#666;
    }
    input:-ms-input-placeholder, textarea:-ms-input-placeholder {
        color:#666;
    }
```

* #### 3, 图片居中显示
```
.imageCenter {
    position: relative;
    top: 50%;
    transform: translateY(-50%);
}

<div>
    <img src="tttt.jpeg" style="width:100px;height:100px;" class="imageCenter"/>
</div>
```

## javascript
* #### 1,jquery
```
$(.xxx)
=> used for class in html elment, e.g,<p id="xxx></p>
$(#xxx)
=> used for id in html element, e.g,<p class="xxx"></p>
$(label)
=> used for label type. e.g,<label></label>
```
