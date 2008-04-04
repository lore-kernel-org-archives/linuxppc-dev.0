Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] RTAS - adapt procfs interface
Date: Fri, 4 Apr 2008 07:39:29 +0200
References: <200804011512.20834.jens@de.ibm.com>
	<20080404001242.GA19506@lst.de>
In-Reply-To: <20080404001242.GA19506@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804040739.30139.arnd@arndb.de>
Cc: Nathan Lynch <ntl@pobox.com>, Christoph Hellwig <hch@lst.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 April 2008, Christoph Hellwig wrote:
> On Tue, Apr 01, 2008 at 03:12:20PM +0200, Jens Osterkamp wrote:
> >=20
> > Hi,
> >=20
> > rtas_flash was broken since 2.6.24-rc5. This patch fixes it.
> > I think this is a good bugfix candidate for 2.6.25.
>=20
> NACK. =A0driver should not poke into the internal count member. =A0Just
> provide your own inclusion with a new counter or set/test_bit.

Well we still have the regression against 2.6.23 and I'd like to
get that fixed in 2.6.25 if it's not already release by the time
we get there.

Would you prefer using Nathan's proper patch for 2.6.25, or do
that for 2.6.26 instead, perhaps using Jens' patch as a quick
fix, as Nathan suggested?

	Arnd <><
