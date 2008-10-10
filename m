Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove bogus ppc_select syscall
Date: Fri, 10 Oct 2008 10:44:41 +0200
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<200809241903.39443.arnd@arndb.de>
	<18671.1794.694965.307451@cargo.ozlabs.ibm.com>
In-Reply-To: <18671.1794.694965.307451@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810101044.41945.arnd@arndb.de>
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 October 2008, Paul Mackerras wrote:
> Arnd Bergmann writes:
>=20
> > Well, the point I made earlier ist that the native ppc32 path should
> > behave the same way as the compat ppc32 path. If we keep ppc_select
> > in one way or another, we should also have a compat wrapper for that,
> > right?
>=20
> No - we have other old system calls that don't exist at all on a
> 64-bit kernel but do on a 32-bit kernel. =A0We decided a long time ago
> that there was no point supporting really ancient 32-bit userland code
> on a 64-bit kernel. =A0That doesn't mean we need to rip out the support
> from the 32-bit kernel.

Ok, that makes sense, thanks for the clarification.

	Arnd <><
