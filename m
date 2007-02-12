Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <ada7iun8bz3.fsf@cisco.com>
References: <200702121129.05004.sr@denx.de>
	<1171281988.20192.1.camel@localhost.localdomain>
	<ada7iun8bz3.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 06:55:08 +1100
Message-Id: <1171310108.20192.7.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Mon, 2007-02-12 at 10:30 -0800, Roland Dreier wrote:
>     Benjamin> David Gibson is making some good progress with the
>     Benjamin> powerpc port, we have ebony booting and emac's up,
>     Benjamin> though he's still ironing out some issues and PCI is
>     Benjamin> still to go. Hopefully, we'll port Taishan next as I
>     Benjamin> really want to have a 440GX in asap.
> 
> Hey Ben, is this work available anywhere?  I am planning on getting
> Katmai (new 440SPe eval board) going soon.  It looks like it will take
> only trivial changes from Yucca (old 440SPe eval board) so I'm
> planning on doing it for arch/ppc first, but I'd be happy to get the
> 440SPe (esp. PCIe stuff) moved to arch/powerpc as soon as makes sense.

Last I asked him (yesterday) he was cleaning up the patches to post a
first batch. So soon, yes.

Note that there are still things that we might want to change. For
example, I think we really should look into adding a macro mecanism
and/or an include mecanism to dtc so that we can do things like #include
<ibm440gp.dtc> to get the base processor/SoC definition and then
"overlay" some properties on top of it (like emac phy mode etc...)

Cheers,
Ben.
