Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1AC7367F96
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 03:02:55 +1000 (EST)
Date: Tue, 9 Aug 2005 10:02:53 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20050809170253.GA29609@gate.ebshome.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B859417@ismail.innsys.innovsys.com>
	<20050809165957.GE22053@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050809165957.GE22053@gate.ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 09:59:57AM -0700, Eugene Surovegin wrote:
> On Tue, Aug 09, 2005 at 11:57:04AM -0500, Rune Torgersen wrote:
> > > -----Original Message-----
> > > From: Eugene Surovegin [mailto:ebs@ebshome.net] 
> > > Sent: Tuesday, August 09, 2005 11:41
> > > Hmm, if I'm correct this clock drift (130ppm) should be 
> > > handled easily 
> > > by NTPD without stepping clock but with slewing. This is why NTPD 
> > > exists in the first place, so I don't see any reason to change 
> > > the kernel.
> > 
> > NTPD probably handles this correct, but I would like the time to be
> > correct anyways. In our case we might not always have access to a ntpd
> > server, and our input clock is very accurate to begin with.
> 
> Well, NTPD doesn't mean you need to have network connectivity, IIRC if 
> you have exact frequency source, you can add it to NTPD and it'll use 
> it to correct drift.

To rephrase this - Linux kernel already has infrastructure for 
precision time keeping, just use it (even without NTPD) and don't add 
any CPU-specific hacks :).

-- 
Eugene
