Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Wed, 3 May 2006 02:18:14 +0200
References: <20060429232812.825714000@localhost.localdomain>
	<200605021259.24157.arnd@arndb.de>
	<801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
In-Reply-To: <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605030218.14428.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Wednesday 03 May 2006 01:38 schrieb Segher Boessenkool:
> > - it requires a few properties in the device tree (local-mac-address,
> > =A0 firmware), so it should also depend on PPC
>
> The portions of code that require OF should have appropriate #ifdef =A0
> guards.

Why should we? Getting the mac address and the firmware into the
chip is rather essential to make it work. When there is an #ifdef
around that code, it will only produce a non-working driver that can
be compiled everywhere instead of a driver that can only be compiled
on platforms where it has a chance of working.

If someone has the need to make it work somewhere else, it's easy
enough to change to code to whatever other method is used to set up
the chip.

	Arnd <><
