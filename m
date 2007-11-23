Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 1DD41DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Nov 2007 10:17:33 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so544968anc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 15:17:32 -0800 (PST)
Message-ID: <fa686aa40711231517x2f71d8dcv43c58860a052b52c@mail.gmail.com>
Date: Fri, 23 Nov 2007 16:17:31 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "narendra sisodiya" <narendra.sisodiya@gmail.com>
Subject: Re: Linux on ML310
In-Reply-To: <e3fb97f30711231452t473f7949x901e4921c20ec699@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e3fb97f30711231452t473f7949x901e4921c20ec699@mail.gmail.com>
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

On 11/23/07, narendra sisodiya <narendra.sisodiya@gmail.com> wrote:
> Hi, I am working ML310 XUP virtex2Pro board. My task is to port a Linux
> 2.4.26 on PowerPC405. I am on the mid way
> I have following question.
>
>
> Why in every document Linux kernel 2.4.26 is used, can i use 2.6.xx version.
> If yes what will be the modifications,

Mainline 2.6.x has support for the virtex device but it is missing
some drivers for EMAC, TEMAC and some other devices.

You can get the drivers from my tree at http://git.secretlab.ca/ or
from the xilinx git server http://git.xilinx.com

> In document some are using busybox for making root file system and in some
> Yellow Dog Linux. so what are the such possible options?

Yellow Dog isn't a very good choice for the ppc405 with no floating
point unit.  Use an embedded distro like ELDK, or build your own using
buildroot or openembedded

> If any body has done some project then Please share your experience with me.
>
>
> --
> Narendra Sisodiya
> MTech (Computer Technology), IIT Delhi
> +91-9999232792
> http://www.techfandu.org/index.html
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
