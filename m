Return-Path: <yding@lnxw.com>
Received: from smtp.lnxw.com (smtp.lnxw.com [207.21.185.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5256667A62
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 May 2006 09:15:57 +1000 (EST)
Message-ID: <445696A9.5070200@lnxw.com>
Date: Mon, 01 May 2006 16:15:53 -0700
From: yding <yding@lnxw.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: question about Linux 2.6 with Xilinx ML-403
References: <4436BD2B.9050306@lnxw.com>
	<528646bc0604071518i5f95b4dbtd232d8cb92ef4fb9@mail.gmail.com>
In-Reply-To: <528646bc0604071518i5f95b4dbtd232d8cb92ef4fb9@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------060105050301010703090803"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060105050301010703090803
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

HI, Grant,

It looks like that the patch for ML-403 in Linux 2.6.17 kernel(I
downloaded from Linus git tree) does not have the directory :
./arch/ppc/platform/4xx/xilinx_ocp like the one in the 2.4.30 kernel.

And also, I saw this thread: "Migrate Xilinx Vertex support from the OCP
bus to the platfom bus"

    http://patchwork.ozlabs.org/linuxppc/patch?id=3933

Does it mean all of onchip peripherals for Virtex-4 FX must reside on
the PLB bus instead of OPB (OCB) bus ?
(i.e. during the process of creating the ref design for Linux using
Xilinx Platform studio, I have to select PLB peripherals instead of OPB
peripherals. Is is correct ?)

BTW, do you have a sample ref design for ML-403 board for Xilinx
Platform studio ?

Thanks for the help.
--
Ying Ding

Grant Likely wrote:

>On 4/7/06, yding <yding@lnxw.com> wrote:
>  
>
>> HI, Grant,
>>
>> I found this message :
>>http://patchwork.ozlabs.org/linuxppc/patch?id=3841 on
>>Internet.
>> It looks like you created some patch files for supporting Linux 2.6 with
>>Xilinx ML-403.
>>
>>how can download the whole kernel source tree with your patched files (via
>>cvs or bitkeeper) ?
>>    
>>
>
>I believe they are now in Linus' mainline git tree.  If not, they are
>in Paul's powerpc git tree.
>
>BTW, please CC the linuxppc-embedded mailing list when emailing me directly.
>
>Cheers,
>g.
>--
>Grant Likely, B.Sc. P.Eng.
>Secret Lab Technologies Ltd.
>(403) 399-0195
>
>  
>

--------------060105050301010703090803
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=GB2312" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
HI, Grant,<br>
<br>
It looks like that the patch for ML-403 in Linux 2.6.17 kernel(I
downloaded from Linus git tree) does not have the directory :
./arch/ppc/platform/4xx/xilinx_ocp like the one in the 2.4.30 kernel. <br>
<br>
And also, I saw this thread: "Migrate Xilinx Vertex support from the
OCP bus to the platfom bus"<br>
<blockquote><a href="http://patchwork.ozlabs.org/linuxppc/patch?id=3933">http://patchwork.ozlabs.org/linuxppc/patch?id=3933</a><br>
</blockquote>
Does it mean all of onchip peripherals for Virtex-4 FX must reside on
the PLB bus instead of OPB (OCB) bus ?&nbsp; <br>
(i.e. during the process of creating the ref design for Linux using
Xilinx Platform studio, I have to select PLB peripherals instead of OPB
peripherals. Is is correct ?)<br>
<br>
BTW, do you have a sample ref design for ML-403 board for Xilinx
Platform studio ?<br>
<br>
Thanks for the help.<br>
--<br>
Ying Ding<br>
<br>
Grant Likely wrote:<br>
<blockquote
 cite="mid528646bc0604071518i5f95b4dbtd232d8cb92ef4fb9@mail.gmail.com"
 type="cite">
  <pre wrap="">On 4/7/06, yding <a class="moz-txt-link-rfc2396E" href="mailto:yding@lnxw.com">&lt;yding@lnxw.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap=""> HI, Grant,

 I found this message :
<a class="moz-txt-link-freetext" href="http://patchwork.ozlabs.org/linuxppc/patch?id=3841">http://patchwork.ozlabs.org/linuxppc/patch?id=3841</a> on
Internet.
 It looks like you created some patch files for supporting Linux 2.6 with
Xilinx ML-403.

how can download the whole kernel source tree with your patched files (via
cvs or bitkeeper) ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I believe they are now in Linus' mainline git tree.  If not, they are
in Paul's powerpc git tree.

BTW, please CC the linuxppc-embedded mailing list when emailing me directly.

Cheers,
g.
--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195

  </pre>
</blockquote>
</body>
</html>

--------------060105050301010703090803--
