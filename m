Return-Path: <antoine.brunet@wirecom-tech.com>
Received: from fbsmtp.clm.net4all.ch (fbsmtp.net4all-dns.com [80.80.228.64])
	by ozlabs.org (Postfix) with ESMTP id C8345DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Mar 2008 19:29:17 +1100 (EST)
Received: from smtp1.clm.net4all.ch (unknown [10.2.0.1])
	by fbsmtp.clm.net4all.ch (Postfix) with ESMTP id 75E8899F7E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Mar 2008 09:04:33 +0100 (CET)
From: "Antoine BRUNET" <antoine.brunet@wirecom-tech.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Linuxppc-embedded Digest, Vol 43, Issue 27
Date: Mon, 17 Mar 2008 09:02:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1.1205629203.1697.linuxppc-embedded@ozlabs.org>
Message-Id: <20080317080424.7B655600AD@smtp1.clm.net4all.ch>
Cc: mamsadegh@hotmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,
Your problem is simple, you just have to add one interruption in your BSP
EDK.
Regerate the bitstream and xparamters. And compile your kernel with the new
xparameters file.
And it will be ok.



Date: Sat, 15 Mar 2008 08:30:31 +0000
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
Subject: Compile time error, compiling Xilinx Linux 2.6 for XPS
	LLTEMAC
To: <linuxppc-embedded@ozlabs.org>
Message-ID: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
Content-Type: text/plain; charset="iso-8859-1"


All,

that should be a small problem, and i think that its solution should be
simple,

I generate a base system using EDK 9.2.02 , the base system contains
XPS_LL_TEMAC , MPMC and other components, I generate the software libraries
and copy xparameters file into proper kernel folder. I configure that kernel
and add kernel support for XPS_LL_TEMAC.

while doing make I encounter this error:

arch/ppc/syslib/virtex_devices.c:455: error:
'XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR' undeclared here (not in a
function)

I think that this definition should be available in xparameters_ml403.h file
but i see that there is no such definition. 
I added a dummy definition for myself there to complete kernel compilation,
don't know the correct value for it of course.

thanks


_________________________________________________________________
Create a handy button so your friends can add U to their buddy list. Try it
now!
http://g.msn.ca/ca55/211
-------------- next part --------------
An HTML attachment was scrubbed...
URL:
<http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20080315/565821b8
/attachment.html>

------------------------------
