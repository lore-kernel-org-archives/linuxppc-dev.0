Return-Path: <dgibson@ozlabs.org>
Date: Sat, 10 Feb 2007 11:53:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: Okay to change default zImage link/load address?
Message-ID: <20070210005330.GD8276@localhost.localdomain>
References: <20070209184345.GA28127@mag.az.mvista.com>
	<20070209185107.GA12703@aepfle.de>
	<20070209185528.GB28127@mag.az.mvista.com>
	<45CCCCAD.2040507@am.sony.com>
	<20070209224010.GB7339@localhost.localdomain>
	<20070209232100.GD12035@mag.az.mvista.com>
	<20070209232533.GE12035@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070209232533.GE12035@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 04:25:33PM -0700, Mark A. Greer wrote:
> On Fri, Feb 09, 2007 at 04:21:00PM -0700, Mark A. Greer wrote:
> > On Sat, Feb 10, 2007 at 09:40:10AM +1100, David Gibson wrote:
> > 
> > > Note that the zImage is already build -fPIC and capable of relocating
> > > itself if loaded at an address other than 4MB...
> > 
> > That doesn't address the issue.
> > 
> > Many firmwares look at the address in the ELF header and that's where
> > they download it, period.  Right now, that address is 4MB, period.
> > 4MB doesn't work on some platforms so I'm looking for an acceptable
> > alternative.
> 
> David, if I sounded rude, I didn't mean to.

No no.  I see your point.

Hrm... I've already been thinking that we'll need to make the crt0.S
replaceable by platform.  The same is probably true for the linker
script.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
