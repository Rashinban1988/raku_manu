// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', () => {

  // ナビゲーションバーガー（navbar-burgerクラスを持つすべての要素）を取得します。
  const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

  // ナビゲーションバーガーがあるかどうかを確認します。
  if ($navbarBurgers.length > 0) {

    // すべてのナビゲーションバーガーをループします。
    $navbarBurgers.forEach( el => {

      // ナビゲーションバーガーにクリックイベントを追加します。
      el.addEventListener('click', () => {

        // ナビゲーションバーガーのdata-target属性の値を取得します。
        const target = el.dataset.target;
        // メニュー（data-target属性の値をIDとして持つ要素）を取得します。
        const $target = document.getElementById(target);

        // ナビゲーションバーガーでis-activeクラスを切り替えます。
        el.classList.toggle('is-active');
        // メニューでis-activeクラスを切り替えます。
        $target.classList.toggle('is-active');

      });
    });
  }
});
