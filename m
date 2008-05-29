Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove reference to dead Makefile variables 
In-reply-to: <20080520045050.GM22279@yookeroo.seuss> 
References: <20080520045050.GM22279@yookeroo.seuss>
Date: Thu, 29 May 2008 08:17:58 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1K1i10-0006C3-EE@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Previous cleanups have removed the LIBFDT_CLEANFILES and
> DTC_CLEANFILES variables from the Makefiles.  However, they're still
> referenced by the Makefile.  This patch gets rid of these last
> vestiges.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
