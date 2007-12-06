Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB9A9DE074
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Dec 2007 06:01:30 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J0LyR-0001cB-HL
	for linuxppc-embedded@ozlabs.org; Thu, 06 Dec 2007 11:01:27 -0800
Message-ID: <14198812.post@talk.nabble.com>
Date: Thu, 6 Dec 2007 11:01:27 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Uboot and ML410
In-Reply-To: <00b501c83782$0f1241b0$2d36c510$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14177109.post@talk.nabble.com>
	<00b501c83782$0f1241b0$2d36c510$@com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




John Hahn wrote:
> 
> We are also using 3.81 make (Centos 5 distro) with ELDK 4.1 version
> downloaded from www.denx.de and have had no problems using the u-boot.zip
> srcs from www.xilinx.com/ml410_p, though we use uboot for our ml403 based
> development, we can build u-boot for ml403_config as well as ml410_config.
> 
> 
> Cheers
> 
> John
> 

When I try compiling with my tools I get the message 
 No rule to make target `hello_world.srec', needed by `all'
Any way to work around this.  I have compiled everything else I use on my
system with these tools and it works fine.  I did some research on this
problem and it seemed to be a problem with the newer versions of make, but
if thats not the case what is the problem?  I don't really want to install
ELDK to keep things consistent.
Thanks
Kevin
-- 
View this message in context: http://www.nabble.com/Uboot-and-ML410-tf4951335.html#a14198812
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
