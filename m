Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 147B667A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 21:10:36 +1100 (EST)
Date: Fri, 18 Mar 2005 02:10:34 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: emre kara <emrekara2002@yahoo.co.uk>
Message-ID: <20050318101034.GD20239@gate.ebshome.net>
References: <20050318094143.34185.qmail@web25708.mail.ukl.yahoo.com>
	<20050318095100.GC20239@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050318095100.GC20239@gate.ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC 440GX kernel 2.6 NAPI driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 18, 2005 at 01:51:00AM -0800, Eugene Surovegin wrote:
> On Fri, Mar 18, 2005 at 09:41:43AM +0000, emre kara wrote:
> > but I can't patch the file for
> > kernel 2.6.11 (emac_3-2.6-9.diff)(on kernel.org).
> > Some .rej files created by patch.(ie mii.rej). Which
> > kernel source must I use as base?
> 
> emac_3-2.6-9.diff is against 2.6 BK tree as of 2005-03-07 11:01pm PST.
> I'll try to find some time this weekend and re-diff (if needed) 
> against latest BK,

OK, I just checked, emac_3-2.6-9.diff should apply cleanly on 
2.6.12-pre1.

--
Eugene
