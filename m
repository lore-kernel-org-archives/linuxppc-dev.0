Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17209.5879.121421.718258@cargo.ozlabs.ibm.com>
Date: Tue, 27 Sep 2005 19:55:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Pantelis Antoniou <panto@intracom.gr>
In-Reply-To: <4339104E.7050705@intracom.gr>
References: <17208.37250.577664.621993@cargo.ozlabs.ibm.com>
	<20050927082324.GA11437@lst.de>
	<17209.817.732159.375607@cargo.ozlabs.ibm.com>
	<43390DDC.7090701@cs.helsinki.fi> <4339104E.7050705@intracom.gr>
Cc: linuxppc-dev@ozlabs.org, Heikki Lindholm <holindho@cs.helsinki.fi>,
	linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pantelis Antoniou writes:

> Count me in too; using a 970 in 32 bit mode, because of gentoo X.org
> problems in 64 bit mode.

I'm using an X.org server on a ppc64 kernel, and it all works,
including DRI.  Both 32-bit and 64-bit X server and clients work.  We
now have the 32-bit ioctl compatibility sorted out in the kernel DRM.
So I don't think X is a reason to run a 32-bit kernel any more.

What X.org problems do you see with a 64-bit kernel?

Paul.
