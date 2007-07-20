Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 04/14] spufs: add spu stats in sysfs and ctx stat file in
	spufs
Date: Fri, 20 Jul 2007 21:29:20 +0200
References: <1184908885751-git-send-email-jk@ozlabs.org>
	<200707202059.26732.arnd@arndb.de>
	<20070720125553.57e7616e.akpm@linux-foundation.org>
In-Reply-To: <20070720125553.57e7616e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707202129.21455.arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Jeremy Kerr <jk@ozlabs.org>, Andre Detsch <adetsch@br.ibm.com>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 20 July 2007, Andrew Morton wrote:
>=20
> I think it's better if you do it, please - I'm not doing anything useful
> here.

Ok, I'm giving it some final testing, then send out the pull request.

Do you also want me to handle the ps3 drivers? I think I'd prefer to
leave those to you if you don't mind.

> Bob has just sent out an udpate to the oprofile patches btw. =A0I'll cc y=
ou
> on the incrementals in case that's some use.

I already have his patch and fixed up the remaining rejects I got against
Christoph's patch.

> btw, I also found the below which I guess I'll merge:
>=20
> From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
>=20
> allnoconfig results in this:
=2E..

Ok.

	Arnd <><
