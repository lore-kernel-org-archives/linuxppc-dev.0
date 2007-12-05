Return-Path: <jhahn@bcfsemi.com>
Received: from raptor.bcfsemi.com (adsl-75-52-244-172.dsl.pltn13.sbcglobal.net
	[75.52.244.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A812DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Dec 2007 08:59:42 +1100 (EST)
Received: from jhahnPC (jhahn-PC.bcfsemi.com [192.168.0.121])
	(authenticated bits=0)
	by raptor.bcfsemi.com (8.13.8/8.13.8) with ESMTP id lB5L2EXL023309
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Dec 2007 13:02:14 -0800
From: "John Hahn" <jhahn@bcfsemi.com>
To: <linuxppc-embedded@ozlabs.org>
References: <14177109.post@talk.nabble.com>
In-Reply-To: <14177109.post@talk.nabble.com>
Subject: RE: Uboot and ML410
Date: Wed, 5 Dec 2007 13:01:51 -0800
Message-ID: <00b501c83782$0f1241b0$2d36c510$@com>
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

We are also using 3.81 make (Centos 5 distro) with ELDK 4.1 version
downloaded from www.denx.de and have had no problems using the u-boot.zip
srcs from www.xilinx.com/ml410_p, though we use uboot for our ml403 based
development, we can build u-boot for ml403_config as well as ml410_config.


Cheers

John
_________________
John S Hahn
BCF Semiconductor



> -----Original Message-----
> From: linuxppc-embedded-bounces+jhahn=bcfsemi.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+jhahn=bcfsemi.com@ozlabs.org] On
> Behalf Of khollan
> Sent: Wednesday, December 05, 2007 10:00 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Uboot and ML410
> 
> 
> Hi
> 
> Is there a patch to include support for the ml410 in the Main git tree
> of u-boot?  I tried compiling Xilinx's tree but it seems it won't
> compile correctly with my version of make (3.81).  Also is there any
> support for the Hard TEMAC in u-boot?  I tried looking for both of
> these questions but a lot of the threads were unanswered questions.
> Thanks for your help
> 
> kholland
> --
