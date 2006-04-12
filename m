Return-Path: <yding@lnxw.com>
Received: from smtp.lnxw.com (smtp.lnxw.com [207.21.185.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85B9367C15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 04:09:23 +1000 (EST)
Message-ID: <443D424D.40607@lnxw.com>
Date: Wed, 12 Apr 2006 11:09:17 -0700
From: yding <yding@lnxw.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: question about Linux 2.6 with Xilinx ML-403
References: <4436BD2B.9050306@lnxw.com>	
	<528646bc0604071518i5f95b4dbtd232d8cb92ef4fb9@mail.gmail.com>	
	<443C61BA.1030404@lnxw.com>
	<528646bc0604112104h7bb011abue5eefd9fcbce7fbd@mail.gmail.com>
In-Reply-To: <528646bc0604112104h7bb011abue5eefd9fcbce7fbd@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------010304070008080904090208"
Cc: linuxppc-embedded@ozlabs.org
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
--------------010304070008080904090208
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

HI, Grant,

I downloaded Paul's git tree as you suggested.

It seems that the defconfig for ML-403(in Patch [9/9]:
http://patchwork.ozlabs.org/linuxppc/patch?id=4226 ), the tri-mode
Ethernet MAC on Virtex-4 FX12 on the ML-403 board was disabled.

Is this Ethernet device supported by this patch ?

Thanks.
--
Ying Ding


Grant Likely wrote:

>On 4/11/06, yding <yding@lnxw.com> wrote:
>  
>
>> I just checked out Linus's GIT tree from
>>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>linux-2.6.
>>
>> Where is the location for Paul's GIT tree ? Just curious ...
>>    
>>
>
>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
>
>g.
>
>--
>Grant Likely, B.Sc. P.Eng.
>Secret Lab Technologies Ltd.
>(403) 399-0195
>
>  
>

--------------010304070008080904090208
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
I downloaded Paul's git tree as you suggested. <br>
<br>
It seems that the defconfig for ML-403(<i>in Patch [9/9]: <a
 href="http://patchwork.ozlabs.org/linuxppc/patch?id=4226">http://patchwork.ozlabs.org/linuxppc/patch?id=4226</a></i>
), the tri-mode Ethernet MAC on Virtex-4 FX12 on the ML-403 board was
disabled. <br>
<br>
Is this Ethernet device supported by this patch ?<br>
<br>
Thanks.<br>
--<br>
Ying Ding<br>
<br>
<br>
Grant Likely wrote:<br>
<blockquote
 cite="mid528646bc0604112104h7bb011abue5eefd9fcbce7fbd@mail.gmail.com"
 type="cite">
  <pre wrap="">On 4/11/06, yding <a class="moz-txt-link-rfc2396E" href="mailto:yding@lnxw.com">&lt;yding@lnxw.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap=""> I just checked out Linus's GIT tree from
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6.

 Where is the location for Paul's GIT tree ? Just curious ...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195

  </pre>
</blockquote>
</body>
</html>

--------------010304070008080904090208--
