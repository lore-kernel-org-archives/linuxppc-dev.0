Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2ADD5B7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 02:57:17 +1100 (EST)
Date: Fri, 30 Oct 2009 10:57:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alessandro Rubini <rubini@gnudd.com>
Subject: Re: Accessing flash directly from User Space [SOLVED]
Message-ID: <20091030155733.GB427@loki.buserror.net>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<20091029233038.GA21587@b07421-ec1.am.freescale.net>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E230FC@midas.usurf.usu.edu>
	<200910301556.11349.mb@bu3sch.de>
	<20091030150855.GA15046@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091030150855.GA15046@mail.gnudd.com>
Cc: bgat@billgatliff.com, linuxppc-dev@lists.ozlabs.org,
	Jonathan.Haws@sdl.usu.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2009 at 04:08:55PM +0100, Alessandro Rubini wrote:
> > asm("eieio; sync");
> 
> Hmm...
> 	: : : "memory"
> 
> And, doesn't ";" start a comment in assembly? (no, not on powerpc it seems)

';' is an instruction separator on all GNU as targets that I'm familiar
with (though a quick manual search shows z80 as an exception).

-Scott
