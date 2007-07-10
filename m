Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Consolidate mm_context_t definition in mmu.h
Date: Tue, 10 Jul 2007 18:55:29 +0200
References: <1184079709.32199.6.camel@weaponx.rchland.ibm.com>
	<200707101836.26413.arnd@arndb.de>
	<1184086042.32199.11.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1184086042.32199.11.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200707101855.30334.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 10 July 2007, Josh Boyer wrote:
> > + =A0 =A0 =A0 u16 user_psize; =A0 =A0 =A0 =A0 /* page size index */
> > +
> > +#ifdef CONFIG_PPC64
>=20
> This needs to be moved up to encompass the u16 user_psize member as
> well, yes?
>=20

Yes, of course. my bad.

	Arnd <><
