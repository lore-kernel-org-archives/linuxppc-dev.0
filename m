Return-Path: <stuarth@freescale.com>
Received: from n082.sc1.he.tucows.com (smtpout0129.sc1.he.tucows.com
	[64.97.136.129]) by ozlabs.org (Postfix) with ESMTP id 85D35DDE1C
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 00:16:06 +1100 (EST)
Subject: Re: [DTC][PATCH] Fix cross-compile building
From: Stuart Hughes <stuarth@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071208003604.GH566@localhost.localdomain>
References: <Pine.LNX.4.64.0712071227280.1788@blarg.am.freescale.net>
	<20071208003604.GH566@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 08 Dec 2007 12:53:25 +0000
Message-Id: <1197118405.3629.6.camel@m20>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-12-08 at 11:36 +1100, David Gibson wrote:
> On Fri, Dec 07, 2007 at 12:28:20PM -0600, Kumar Gala wrote:
> > From: Stuart Hughes <stuarth@freescale.com>
> > 
> > This patch allows you to build the DTC source without making the
> > tests directory.  This is necessary when cross compiling as the
> > dumptest (and other) files cannot be run/used on the host system.
> > To use this use: 'make TESTS='
> 
> I think this is a silly way of doing this.  Instead create a new
> target which builds everything but the tests.
> 
> Say,
> 
> 	all: cross tests
> 
> 	cross: dtc ftdump libfdt
> 

Works for me.

Regards, Stuart
