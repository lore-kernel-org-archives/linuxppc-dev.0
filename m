Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 774C7DE02C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 00:21:32 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J2o0H-0007xz-BX
	for linuxppc-embedded@ozlabs.org; Thu, 13 Dec 2007 05:21:29 -0800
Message-ID: <14315916.post@talk.nabble.com>
Date: Thu, 13 Dec 2007 05:21:29 -0800 (PST)
From: greenlean <jmgomez@atc.ugr.es>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to Build Rootfile system
In-Reply-To: <e8e184520712122203s12b9742ckbee6b1afbee7d50f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <e8e184520712122203s12b9742ckbee6b1afbee7d50f@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Maybe this web 
http://www.cs.washington.edu/research/lis/empart/xup_ppc_linux.shtml Porting
linux to XUPV2P  could be usefull.

I built the busybox root filesystem for an arm processor some years ago,
using cross_compiler and a uclibc library. This works fine...


vinay kumar-9 wrote:
> 
> Hi All,
> 
> I have booted linux on PPC440GP with treeimage(zimage+initrd).
> Now my next aim is to have a more stable rootfile system.
> 
> I wanted to know the procedure of building a root file system for PPC440GP
> architecture.
> 
> Pls share your knowledge and also some links.
> 
> 
> regards to all,
> vinay
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/How-to-Build-Rootfile-system-tp14310539p14315916.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
