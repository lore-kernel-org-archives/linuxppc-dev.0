Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 64F9C67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 08:29:29 +1000 (EST)
Date: Fri, 22 Apr 2005 15:29:26 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Wolfgang Denk <wd@denx.de>
Message-ID: <20050422222925.GB9158@gate.ebshome.net>
References: <20050422210610.GA9158@gate.ebshome.net>
	<20050422222601.35F18C1510@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050422222601.35F18C1510@atlas.denx.de>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Warm reboot on 826x targets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Apr 23, 2005 at 12:25:56AM +0200, Wolfgang Denk wrote:
> In message <20050422210610.GA9158@gate.ebshome.net> you wrote:
> > 
> > This is not relevant, because Linux doesn't use this "checkstop" 
> > trick. It directly just jumps to U-Boot warm-reboot entry point.
> 
> Which is a bad design desicion, IMHO. If you want to reset  a  board,
> you  should  really  RESET  it  (and  give all attached peripherals a
> chance to get reset, too), instead of just assuming everything is  in
> good shape an it's sufficient to just jump into some boot loader code
> again.

Sure, but tell me then, _WHY_ U-Boot has this warm-reboot entry?

IMHO, Motorola should have implemented normal reset facility, which 
doesn't require any tricks.

-- 
Eugene
