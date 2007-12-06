Return-Path: <jhahn@bcfsemi.com>
Received: from raptor.bcfsemi.com (adsl-75-52-244-172.dsl.pltn13.sbcglobal.net
	[75.52.244.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0520BDDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Dec 2007 06:55:53 +1100 (EST)
Received: from jhahnPC (jhahn-PC.bcfsemi.com [192.168.0.121])
	(authenticated bits=0)
	by raptor.bcfsemi.com (8.13.8/8.13.8) with ESMTP id lB6JtoEN031154
	for <linuxppc-embedded@ozlabs.org>; Thu, 6 Dec 2007 11:55:50 -0800
From: "John Hahn" <jhahn@bcfsemi.com>
To: <linuxppc-embedded@ozlabs.org>
References: <14177109.post@talk.nabble.com>	<00b501c83782$0f1241b0$2d36c510$@com>
	<14198812.post@talk.nabble.com>
In-Reply-To: <14198812.post@talk.nabble.com>
Subject: RE: Uboot and ML410
Date: Thu, 6 Dec 2007 11:55:49 -0800
Message-ID: <000c01c83841$ffabfbb0$ff03f310$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This thread really belongs in the u-boot mailing list, I will respond there:

U-Boot-Users mailing list
U-Boot-Users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/u-boot-users

Cheers

John

> -----Original Message-----
> From: linuxppc-embedded-bounces+jhahn=bcfsemi.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+jhahn=bcfsemi.com@ozlabs.org] On
> Behalf Of khollan
> Sent: Thursday, December 06, 2007 11:01 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: RE: Uboot and ML410
> 
> 
> 
> 
> John Hahn wrote:
> >
> > We are also using 3.81 make (Centos 5 distro) with ELDK 4.1 version
> > downloaded from www.denx.de and have had no problems using the
> > u-boot.zip srcs from www.xilinx.com/ml410_p, though we use uboot for
> > our ml403 based development, we can build u-boot for ml403_config as
> well as ml410_config.
> >
> >
> > Cheers
> >
> > John
> >
> 
> When I try compiling with my tools I get the message  No rule to make
> target `hello_world.srec', needed by `all'
> Any way to work around this.  I have compiled everything else I use on
> my system with these tools and it works fine.  I did some research on
> this problem and it seemed to be a problem with the newer versions of
> make, but if thats not the case what is the problem?  I don't really
> want to install ELDK to keep things consistent.
> Thanks
> Kevin
> --
> View this message in context: http://www.nabble.com/Uboot-and-ML410-
> tf4951335.html#a14198812
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
