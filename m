Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E31F01A275B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 21:30:03 +1000 (AEST)
Received: from [192.168.1.106] (ppp-93-104-80-87.dynamic.mnet-online.de
 [93.104.80.87]) by smtp.strato.de (RZmta 37.11 DYNA|AUTH)
 with ESMTPSA id i00781r87B5m6De
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH
 bits, eq. 15360 bits RSA)) (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 7 Sep 2015 13:05:48 +0200 (CEST)
Subject: FYI: iceweasel 40.X.X PowerPC isn't available for Debian PPC32
To: linuxppc-dev@lists.ozlabs.org
References: <55E5DF60.2060205@xenosoft.de>
 <20150901180228.GS15616@csclub.uwaterloo.ca> <55E68B55.1000003@xenosoft.de>
 <55ED4508.4010608@xenosoft.de>
 <CAK90Sjm5JnDrtVLpUQ2=GJ2zXaX0HGMkdx46ACcHPFP0bxsUmA@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <55ED6F8C.7050003@xenosoft.de>
Date: Mon, 7 Sep 2015 13:05:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAK90Sjm5JnDrtVLpUQ2=GJ2zXaX0HGMkdx46ACcHPFP0bxsUmA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------000100030503040002080608"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000100030503040002080608
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

FYI:

On 07 September 2015 at 11:07 AM, Boris Reinhard 
[debian-powerpc@lists.debian.org] wrote:
>
>
> Off-list reply, please don't quote/ forward
>
> Hi,
>
> wrong list, please use this one if you want to reach ppl that do 
> active work on ppc:
>
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> Come to think of it, it might be interesting/ helpful contacting 
> Cameron Kaiser (tenfourfox) and Tobias Netzel (webkit for leopard) 
> additionally, asking about how or if their ppc osx work could 
> potentially/ at all benefit linux ppc!?
>
> Grüße
> Boris Reinhard
>
> Hi All,
>
> Iceweasel was updated to version 40.0.3-3 for the unofficial Debian 
> PPC64 port. I installed it inside my Debian PPC64 chroot. 
> Unfortunately it doesn't start either.
>
> Note: Iceweasel and Firefox 40.X.X PowerPC aren't available for all 
> Ubuntu flavours and for Debian with 32-bit userland currently.
>
> Cheers,
>
> Christian
>
> On 02 September 2015 at 07:38 AM, Christian Zigotzky wrote:
>
>     Hi Lennart,
>
>     Thank you for your answer.
>
>     Unfortunately the increasing of the stack spaces wasn't successfully.
>
>     I tried the following stack sizes:
>
>     ulimit -s 16384
>     ulimit -s 32768
>     ulimit -s 65536
>     ulimit -s 131072
>
>     iceweasel Debian PPC64 in a chroot:
>
>     too much recursion
>     Segmentation fault
>
>     Rgds,
>
>     Christian
>
>
>     On 01 September 2015 at 8:02 PM, Lennart Sorensen
>     [debian-powerpc@lists.debian.org] wrote:
>
>         On Tue, Sep 01, 2015 at 07:24:48PM +0200, Christian Zigotzky
>         wrote:
>
>             Hi All,
>
>             Iceweasel and Firefox 40.X.X PowerPC aren't available for
>             all Ubuntu
>             flavours and for Debian with 32-bit userland currently.
>
>             There are build problems:
>
>             Iceweasel 40 build status:
>             https://packages.debian.org/de/experimental/iceweasel
>
>             Firefox 40 build status:
>             https://launchpad.net/ubuntu/+source/firefox/
>
>             But iceweasel 40.0.3-1 was released for the unofficial
>             Debian PPC64 port. I
>             installed it inside my Debian PPC64 chroot. Unfortunately
>             it doesn't start.
>
>             Error messages:
>
>             too much recursion
>             Segmentation fault
>
>             Is anyone working on resolving this issue?
>
>         Could you try what happens if you change the stack size limit?
>
>         ulimit -s 16384 (I believe the current default that you can
>         check with
>         ulimit -a is 8192).  Could even try something even bigger like
>         65536.
>         Then run firefox from that terminal where you changed the limit
>         temporarily.
>
>         Certainly with 64 bit pointers and 64 bit registers, ppc64
>         could be using
>         quite a bit of stack space in the javascript engine, which
>         appears to
>         be the thing that always causes this error in firefox (seems
>         to happen
>         everytime they change the engine in a major way, and then
>         things get
>         tweaked until it works again, then it gets broken again).
>
>
>


--------------000100030503040002080608
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">FYI:<br>
      <br>
      On 07 September 2015 at 11:07 AM, Boris Reinhard
      [<a class="moz-txt-link-abbreviated" href="mailto:debian-powerpc@lists.debian.org">debian-powerpc@lists.debian.org</a>] wrote:<br>
    </div>
    <blockquote
cite="mid:CAK90Sjm5JnDrtVLpUQ2=GJ2zXaX0HGMkdx46ACcHPFP0bxsUmA@mail.gmail.com"
      type="cite">
      <p dir="ltr"><br>
        Off-list reply, please don't quote/ forward</p>
      <p dir="ltr">Hi, </p>
      <p dir="ltr">wrong list, please use this one if you want to reach
        ppl that do active work on ppc: </p>
      <p dir="ltr"><a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
      </p>
      <p dir="ltr">Come to think of it, it might be interesting/ helpful
        contacting Cameron Kaiser (tenfourfox) and Tobias Netzel (webkit
        for leopard) additionally, asking about how or if their ppc osx
        work could potentially/ at all benefit linux ppc!?</p>
      <p dir="ltr">Grüße<br>
        Boris Reinhard<br>
      </p>
      <div class="gmail_quot&lt;blockquote class=" style="margin:0 0 0
        .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi All,<br>
        <br>
        Iceweasel was updated to version 40.0.3-3 for the unofficial
        Debian PPC64 port. I installed it inside my Debian PPC64 chroot.
        Unfortunately it doesn't start either.<br>
        <br>
        Note: Iceweasel and Firefox 40.X.X PowerPC aren't available for
        all Ubuntu flavours and for Debian with 32-bit userland
        currently.<br>
        <br>
        Cheers,<br>
        <br>
        Christian<br>
        <br>
        On 02 September 2015 at 07:38 AM, Christian Zigotzky wrote:<br>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">
          Hi Lennart,<br>
          <br>
          Thank you for your answer.<br>
          <br>
          Unfortunately the increasing of the stack spaces wasn't
          successfully.<br>
          <br>
          I tried the following stack sizes:<br>
          <br>
          ulimit -s 16384<br>
          ulimit -s 32768<br>
          ulimit -s 65536<br>
          ulimit -s 131072<br>
          <br>
          iceweasel Debian PPC64 in a chroot:<br>
          <br>
          too much recursion<br>
          Segmentation fault<br>
          <br>
          Rgds,<br>
          <br>
          Christian<br>
          <br>
          <br>
          On 01 September 2015 at 8:02 PM, Lennart Sorensen
          [<a class="moz-txt-link-abbreviated" href="mailto:debian-powerpc@lists.debian.org">debian-powerpc@lists.debian.org</a>] wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            On Tue, Sep 01, 2015 at 07:24:48PM +0200, Christian Zigotzky
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              Hi All,<br>
              <br>
              Iceweasel and Firefox 40.X.X PowerPC aren't available for
              all Ubuntu<br>
              flavours and for Debian with 32-bit userland currently.<br>
              <br>
              There are build problems:<br>
              <br>
              Iceweasel 40 build status:<br>
              <a moz-do-not-send="true"
                href="https://packages.debian.org/de/experimental/iceweasel"
                rel="noreferrer" target="_blank">https://packages.debian.org/de/experimental/iceweasel</a><br>
              <br>
              Firefox 40 build status: <a moz-do-not-send="true"
                href="https://launchpad.net/ubuntu/+source/firefox/"
                rel="noreferrer" target="_blank">https://launchpad.net/ubuntu/+source/firefox/</a><br>
              <br>
              But iceweasel 40.0.3-1 was released for the unofficial
              Debian PPC64 port. I<br>
              installed it inside my Debian PPC64 chroot. Unfortunately
              it doesn't start.<br>
              <br>
              Error messages:<br>
              <br>
              too much recursion<br>
              Segmentation fault<br>
              <br>
              Is anyone working on resolving this issue?<br>
            </blockquote>
            Could you try what happens if you change the stack size
            limit?<br>
            <br>
            ulimit -s 16384 (I believe the current default that you can
            check with<br>
            ulimit -a is 8192).  Could even try something even bigger
            like 65536.<br>
            Then run firefox from that terminal where you changed the
            limit<br>
            temporarily.<br>
            <br>
            Certainly with 64 bit pointers and 64 bit registers, ppc64
            could be using<br>
            quite a bit of stack space in the javascript engine, which
            appears to<br>
            be the thing that always causes this error in firefox (seems
            to happen<br>
            everytime they change the engine in a major way, and then
            things get<br>
            tweaked until it works again, then it gets broken again).<br>
            <br>
          </blockquote>
          <br>
        </blockquote>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------000100030503040002080608--
