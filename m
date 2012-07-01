Return-Path: <william76.sh@gmail.com>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14E682C01C7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Jul 2012 23:51:40 +1000 (EST)
Received: by ghbg24 with SMTP id g24so3553291ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Jul 2012 06:51:37 -0700 (PDT)
Message-ID: <4FF055AC.2070103@gmail.com>
Date: Sun, 01 Jul 2012 10:50:36 -0300
From: "William F." <william76.sh@gmail.com>
MIME-Version: 1.0
To: stephan@gatzka.org
Subject: Re: MPC5200b jffs2 memcpy alignment problem
References: <1341086991.2252.0@antares> <4FEFF265.3010102@gatzka.org>
In-Reply-To: <4FEFF265.3010102@gatzka.org>
Content-Type: multipart/alternative;
 boundary="------------090806030606020404040405"
Cc: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
 linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090806030606020404040405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(SPAM)


Em 01-07-2012 03:47, Stephan Gatzka escreveu:
> Hi Albrecht,
>
> > I don't recall who proposed this patch, but exactly this solution is
> > around for a longer time (mayby you search archives...).  On my 
> board, I
> > have a flash chip attached to the LocalBus in 16-bit mode.  Based on
> > 3.2.16, the patch is:
>
> Thanks for your answer and yes, this patch will definitely work. But I 
> want to have a solution in the mainline kernel, that's why I'm asking 
> how to deal best with this problem.
>
> Regards,
>
> Stephan
>
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


--------------090806030606020404040405
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    (SPAM)<br>
    <br>
    <br>
    Em 01-07-2012 03:47, Stephan Gatzka escreveu:
    <blockquote cite="mid:4FEFF265.3010102@gatzka.org" type="cite">Hi
      Albrecht,
      <br>
      <br>
      &gt; I don't recall who proposed this patch, but exactly this
      solution is
      <br>
      &gt; around for a longer time (mayby you search archives...).&nbsp; On
      my board, I
      <br>
      &gt; have a flash chip attached to the LocalBus in 16-bit mode.&nbsp;
      Based on
      <br>
      &gt; 3.2.16, the patch is:
      <br>
      <br>
      Thanks for your answer and yes, this patch will definitely work.
      But I want to have a solution in the mainline kernel, that's why
      I'm asking how to deal best with this problem.
      <br>
      <br>
      Regards,
      <br>
      <br>
      Stephan
      <br>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">______________________________________________________
Linux MTD discussion mailing list
<a class="moz-txt-link-freetext" href="http://lists.infradead.org/mailman/listinfo/linux-mtd/">http://lists.infradead.org/mailman/listinfo/linux-mtd/</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------090806030606020404040405--
