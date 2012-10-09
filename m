Return-Path: <B08782@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E42752C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 03:37:23 +1100 (EST)
Message-ID: <507452B0.7040401@freescale.com>
Date: Tue, 9 Oct 2012 19:37:04 +0300
From: Claudiu Manoil <claudiu.manoil@freescale.com>
MIME-Version: 1.0
To: Avi Tsarfati <Avi.Tsarfati@alvarion.com>
Subject: Re: gianfar driver crash on P1020
References: <56439212F1FB0D45B3354883689F4245559383@yoqex01.alvarion.com>
In-Reply-To: <56439212F1FB0D45B3354883689F4245559383@yoqex01.alvarion.com>
Content-Type: multipart/alternative;
 boundary="------------030708000904040905040007"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------030708000904040905040007
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Did you try this patch?
http://patchwork.ozlabs.org/patch/186315/

Claudiu

On 10/9/2012 3:22 PM, Avi Tsarfati wrote:
>
> Hi,
>
> I have the same problem as you do.
>
> Have you found the CPU stuck reason (or fix) in P1020RDB board ?
>
> Thanks,
>
> Avi Tsarfati.
>
>
>
> ************************************************************************************ 
>
> This footnote confirms that this email message has been scanned by
> PineApp Mail-SeCure for the presence of malicious code, vandals & 
> computer viruses(187).
> ************************************************************************************
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------030708000904040905040007
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hello,<br>
    <br>
    Did you try this patch?<br>
    <a class="moz-txt-link-freetext" href="http://patchwork.ozlabs.org/patch/186315/">http://patchwork.ozlabs.org/patch/186315/</a><br>
    <br>
    Claudiu<br>
    <br>
    <div class="moz-cite-prefix">On 10/9/2012 3:22 PM, Avi Tsarfati
      wrote:<br>
    </div>
    <blockquote
      cite="mid:56439212F1FB0D45B3354883689F4245559383@yoqex01.alvarion.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <meta name="Generator" content="Microsoft Word 12 (filtered
        medium)">
      <style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1" />
 </o:shapelayout></xml><![endif]-->
      <div class="Section1">
        <p class="MsoNormal">Hi, <o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">I have the same problem as you do. <o:p></o:p></p>
        <p class="MsoNormal">Have you found the CPU stuck reason (or
          fix) in P1020RDB
          board ?<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"
          style="mso-margin-top-alt:5.0pt;margin-right:0cm;margin-bottom:
          5.0pt;margin-left:0cm">Thanks,<o:p></o:p></p>
        <p class="MsoNormal"
          style="mso-margin-top-alt:5.0pt;margin-right:0cm;margin-bottom:
          5.0pt;margin-left:0cm">Avi Tsarfati.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
      </div>
      <br>
      <br>
      ************************************************************************************
      <br>
      This footnote confirms that this email message has been scanned by
      <br>
      PineApp Mail-SeCure for the presence of malicious code, vandals
      &amp; computer viruses(187). <br>
************************************************************************************<br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------030708000904040905040007--
