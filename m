Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 686F0DE005
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 04:28:27 +1000 (EST)
Date: Fri, 15 Jun 2007 13:28:03 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Message-Id: <20070615132803.00e43768.kim.phillips@freescale.com>
In-Reply-To: <B4E893D5-A61E-4A91-B31C-AF9B7C0B116D@kernel.crashing.org>
References: <20070612163016.253915076@arndb.de>
	<18032.40447.579128.989284@cargo.ozlabs.ibm.com>
	<B4E893D5-A61E-4A91-B31C-AF9B7C0B116D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de,
	sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Jun 2007 08:33:19 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jun 13, 2007, at 8:46 PM, Paul Mackerras wrote:
> 
> > Most of this series of patches touch 8xxx or 5xxx stuff in one way or
> > another, so I'll leave it to Kumar to make the decision about them.
> > I'll put in 1/13.
> 
> Arnd,
> 
> I'm a little hesitant to move the embedded ppc's over to  
> multiplatform quite yet.  One feature I wanted was in Kconfig a way  
> to enforce the selection of at least one choice, as well as being  
> able to optimize things since we only had one choice selected.
> 
> See the following thread for discussion I had with Sam & Roman on the  
> subject:
> 
> http://marc.info/?t=117156757000002&r=1&w=2
> 

FWIW, this patchseries tests ok on 83xx, and I didn't have a problem
selecting at least one choice ;)

Kim
