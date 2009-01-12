Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id BE533DDFA4
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 19:07:58 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.28-git-4 - powerpc - kernel expection 'c01 at
	.kernel_thread'
Date: Mon, 12 Jan 2009 09:07:19 +0100
References: <20090102125752.GA5743@linux.vnet.ibm.com>
	<200901110108.20848.rjw@sisk.pl>
	<20090112072132.GA8409@linux.vnet.ibm.com>
In-Reply-To: <20090112072132.GA8409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901120907.20418.rjw@sisk.pl>
Cc: sfr@canb.auug.org.au, linux-mm@kvack.org, mel@csn.ul.ie,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 12 January 2009, Kamalesh Babulal wrote:
> * Rafael J. Wysocki <rjw@sisk.pl> [2009-01-11 01:08:19]:
> 
> > On Friday 02 January 2009, Kamalesh Babulal wrote:
> > > Hi,
> > > 
> > > 	2.6.28-git4 kernel drops to xmon with kernel expection. Similar kernel
> > > expection was seen next-20081230 and next-20081231 and was reported 
> > > earlier at http://lkml.org/lkml/2008/12/31/157
> > 
> > Is this a regression from 2.6.27?
> > 
> > Rafael
> >
> 
> This is not a regression from 2.6.27, this expection was first seen 
> next-20081230 patches and then was introduced into 2.6.28-git4 and is 
> reproducible with 2.6.28-rc1 kernel.

Presumably you meant 2.6.29-rc1 ?  In which case it would be a regression from
2.6.28 .  Please confirm.

Thanks,
Rafael
