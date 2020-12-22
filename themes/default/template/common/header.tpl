<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta property="og:type" content="website"/>
  <meta property="og:title" content="<?php echo $title; ?>">
  <meta property="og:description"
        content="<?= $description ? $description : '' ?>"><?php if ($class == 'common-home') { ?>
    <meta property="og:url" content="<?php echo $base; ?>">
    <?php }; ?>
  <meta property="og:site_name" content="<?php echo Config::get('config_name') ?>">
  <title><?php echo $title; ?></title>
  <base href="<?php echo $base; ?>"/>
    <?php if ($description) { ?>
      <meta name="description" content="<?php echo $description; ?>"/>
    <?php } ?>
    <?php if ($keywords) { ?>
      <meta name="keywords" content="<?php echo $keywords; ?>"/>
    <?php } ?>
    <?php foreach ($styles as $style) { ?>
      <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>"
            media="<?php echo $style['media']; ?>, print"/>
    <?php } ?>

    <?php foreach ($links as $link) { ?>
      <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>"/>
    <?php } ?>
    <?php foreach ($scripts as $script) { ?>
      <script src="<?php echo $script; ?>" type="text/javascript"></script>
    <?php } ?>
    <?php foreach ($analytics as $analytic) { ?>
        <?php echo $analytic; ?>
    <?php } ?>
</head>
<body class="<?php echo $class; ?>">
<nav id="top">
  <div class="container">
      <?php echo $currency; ?>
      <?php echo $language; ?>
    <div id="top-links" class="nav pull-right">
        <?php if (!$cms_hide_top_eshop_links) { ?>
          <ul class="list-inline list">
              <?php if ($telephone) { ?>
                <li class="list-item"><a href="<?php echo $contact; ?>"><i class="fa fa-phone"></i></a> <span
                      class="hidden-xs hidden-sm hidden-md"><?php echo $telephone; ?></span></li>
              <?php } ?>
            <li class="dropdown">
                <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <span
                    class="hidden-xs hidden-sm hidden-md"><?php echo $text_account; ?></span> <span
                    class="caret"></span></a>
              <ul class="dropdown-menu dropdown-menu-right">
                  <?php if ($logged) { ?>
                    <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                    <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                    <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
                    <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                    <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
                  <?php } else { ?>
                    <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
                    <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
                  <?php } ?>
              </ul>
            </li>
            <li><a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>"><i
                    class="fa fa-heart"></i> <span
                    class="hidden-xs hidden-sm hidden-md"><?php echo $text_wishlist; ?></span></a></li>
            <li><a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>"><i
                    class="fa fa-shopping-cart"></i> <span
                    class="hidden-xs hidden-sm hidden-md"><?php echo $text_shopping_cart; ?></span></a></li>
            <li><a href="<?php echo $checkout; ?>" title="<?php echo $text_checkout; ?>"><i class="fa fa-share"></i>
                <span class="hidden-xs hidden-sm hidden-md"><?php echo $text_checkout; ?></span></a></li>
          </ul>
        <?php } ?>
    </div>
  </div>
</nav>
<header>
  <div class="container">
    <div class="row">
      <div class="col-sm-3">
        <div id="logo">
            <?php if ($logo) { ?>
              <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>"
                                                  alt="<?php echo $name; ?>" class="img-responsive"/></a>
            <?php } else { ?>
              <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
            <?php } ?>
        </div>
      </div>
        <?php if (!$cms_hide_top_search) { ?>
          <div class="col-md-6 col-sm-5"><?php echo $search; ?>
          </div>
        <?php } ?>
        <?php if (!$cms_hide_top_cart) { ?>
          <div id="cart" class="col-md-3 col-sm-4"><?php echo $cart; ?></div>
        <?php } ?>
    </div>
  </div>
</header>
<?php if ($categories || $informations) { ?>

<div class="container">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <!--                <a class="navbar-brand" href="#">Navbar</a>-->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                    </li>

                    <?php if ($categories) { ?>
                        <?php foreach ($categories as $category) { ?>

                            <li class="nav-item">
                                <a class="nav-link" href="<?php echo $category['href'] ?>"><?php echo $category['name'] ?></a>
                            </li>

                        <?php } ?>
                    <?php } ?>

                    <?php if ($informations) { ?>
                        <?php foreach ($informations as $information) { ?>
                            <li class="nav-item">
                                <a class="nav-link" href="<?php echo $information['href'] ?>"><?php echo $information['name'] ?></a>
                            </li>
                        <?php } ?>
                    <?php } ?>


                    <!--                        <li class="nav-item">-->
                    <!--                            <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>-->
                    <!--                        </li>-->
                </ul>
            </div>
        </div>
    </nav>
</div>

    <?php /*> <div class="container">
    <nav id="menu" class="navbar">
      <div class="navbar-header"><span id="category" class="visible-xs"><?php echo $text_category; ?></span>
        <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse"
                data-target=".navbar-ex1-collapse"><i class="fa fa-bars"></i></button>
      </div>






      <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav">
            <?php if ($categories) { ?>
                <?php foreach ($categories as $category) { ?>
                    <?php if ($category['children']) { ?>
                  <li class="dropdown"><a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?></a>
                    <div class="dropdown-menu">
                      <div class="dropdown-inner">
                          <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                            <ul class="list-unstyled">
                                <?php foreach ($children as $child) { ?>
                                  <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                                <?php } ?>
                            </ul>
                          <?php } ?>
                      </div>
                      <a href="<?php echo $category['href']; ?>"
                         class="see-all"><?php echo $text_all; ?><?php echo $category['name']; ?></a></div>
                  </li>
                    <?php } else { ?>
                  <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                    <?php } ?>
                <?php } ?>
            <?php } ?>
            <?php if ($informations) { ?>
                <?php foreach ($informations as $information) { ?>
                <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                <?php } ?>
            <?php } ?>
        </ul>
      </div>
  </nav>
  </div><*/ ?>
<?php } ?>
