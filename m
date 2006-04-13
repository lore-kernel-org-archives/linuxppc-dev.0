Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id CF86267CF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Apr 2006 01:23:00 +1000 (EST)
Date: Thu, 13 Apr 2006 17:03:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Laurent Lagrange <lagrange@fr.oleane.com>
Subject: Re: NAND and JFFS2 supports in Linux 2.4
Message-ID: <20060413150317.GC30574@wohnheim.fh-wedel.de>
References: <1144790375.3659.3.camel@yoda.jdub.homelinux.org>
	<006201c65f09$7d809140$5201a8c0@GEG2400>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <006201c65f09$7d809140$5201a8c0@GEG2400>
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

On Thu, 13 April 2006 16:49:35 +0200, Laurent Lagrange wrote:
> > -----Message d'origine-----
> > De : Josh Boyer
> 
> > > Linux 2.4.18 or 2.4.25 do not support this device,
> > Those are entire too old.
> Except for some customers which must maintain kernels during many years :-)
> 
> > > Linux 2.4.31 seems supporting this device but JFFS2 is not adapted,
> > NAND + JFFS2 + 2.4 is not a supported combination.
> That's the problem i am facing with.

Supporting an old system for years is one thing.  Adding new features
is a completely different beast.  Looks like you have to spend some
substantial time, just to get something running.  Are you sure this is
desired and preferred over a kernel upgrade?  Might be worth
rethinking.

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
