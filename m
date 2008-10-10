Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18671.1794.694965.307451@cargo.ozlabs.ibm.com>
Date: Fri, 10 Oct 2008 18:40:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] remove bogus ppc_select syscall
In-Reply-To: <200809241903.39443.arnd@arndb.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<200809240839.14902.arnd@arndb.de>
	<18650.27350.410563.484089@cargo.ozlabs.ibm.com>
	<200809241903.39443.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> Well, the point I made earlier ist that the native ppc32 path should
> behave the same way as the compat ppc32 path. If we keep ppc_select
> in one way or another, we should also have a compat wrapper for that,
> right?

No - we have other old system calls that don't exist at all on a
64-bit kernel but do on a 32-bit kernel.  We decided a long time ago
that there was no point supporting really ancient 32-bit userland code
on a 64-bit kernel.  That doesn't mean we need to rip out the support
from the 32-bit kernel.

Paul.
