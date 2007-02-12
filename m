Return-Path: <rdreier@cisco.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
References: <200702121129.05004.sr@denx.de>
	<1171281988.20192.1.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 12 Feb 2007 10:30:56 -0800
In-Reply-To: <1171281988.20192.1.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Mon, 12 Feb 2007 23:06:28 +1100")
Message-ID: <ada7iun8bz3.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    Benjamin> David Gibson is making some good progress with the
    Benjamin> powerpc port, we have ebony booting and emac's up,
    Benjamin> though he's still ironing out some issues and PCI is
    Benjamin> still to go. Hopefully, we'll port Taishan next as I
    Benjamin> really want to have a 440GX in asap.

Hey Ben, is this work available anywhere?  I am planning on getting
Katmai (new 440SPe eval board) going soon.  It looks like it will take
only trivial changes from Yucca (old 440SPe eval board) so I'm
planning on doing it for arch/ppc first, but I'd be happy to get the
440SPe (esp. PCIe stuff) moved to arch/powerpc as soon as makes sense.

Thanks,
  Roland
