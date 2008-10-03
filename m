Return-Path: <hofrat@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id E94E4DDF9C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Oct 2008 04:38:08 +1000 (EST)
Date: Fri, 3 Oct 2008 10:01:35 -0800 (AKDT)
From: Nicholas Mc Guire <hofrat@hofr.at>
To: Fillod Stephane <stephane.fillod@thomson.net>
Subject: RE: SA-RTLinux for ppc?
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD383BB@rennsmail04.eu.thmulti.com>
Message-ID: <Pine.LNX.4.58.0810030958420.2907@vlab.hofr.at>
References: <0B45E93C5FF65740AEAE690BF3848B7AD383BB@rennsmail04.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, sumedh tirodkar <sumedhtirodkar@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> sumedh tirodkar wrote:
> > does there exist a Standalone RTLinux for powerpc?
> >
>
> I don't know, but there's a very good hard real-time extension called
> Xenomai
> for powerpc (and many other arch's). http://www.xenomai.org
>
RTLinux/GPL (www.rtlinux-gpl.org) currently does not support PPC though
we do have the first ports for PPC 440 and 405 of XtratuM in testing it
will be some time before RTLinux is fully available in a stable release.
So atleast for now xenomai is your best bet for a free-software real-time
extension. If you are interested in testing early releases let me know
though.

thx!
hofrat
