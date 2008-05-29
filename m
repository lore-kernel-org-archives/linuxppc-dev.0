Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Seval cleanups to parameter checking (v3) 
In-reply-to: <20080520071911.GR22279@yookeroo.seuss> 
References: <20080520063325.GQ22279@yookeroo.seuss>
	<20080520071911.GR22279@yookeroo.seuss>
Date: Thu, 29 May 2008 08:19:19 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1K1i2J-0006CN-HA@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Subject: Re: libfdt: Seval cleanups to parameter checking (v3) 

Please put the "(v3)" in brackets at the begining of the Subject:.

> This patch makes a couple of small cleanups to parameter checking of
> libfdt functions.
> 
> 	- In several functions which take a node offset, we use an
> idiom involving fdt_next_tag() first to check that we have indeed been
> given a node offset.  This patch adds a helper function
> _fdt_check_node_offset() to encapsulate this usage of fdt_next_tag().
> 
> 	- In fdt_rw.c in several places we have the expanded version
> of the RW_CHECK_HEADER() macro for no particular reason.  This patch
> replaces those instances with an invocation of the macro; that's what
> it's for.
> 
> 	- In fdt_sw.c we rename the check_header_sw() function to
> sw_check_header() to match the analgous function in fdt_rw.c, and we
> provide an SW_CHECK_HEADER() wrapper macro as RW_CHECK_HEADER()
> functions in fdt_rw.c
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>


Applied.

jdl
