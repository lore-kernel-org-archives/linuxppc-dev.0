Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17518.18355.797018.210373@cargo.ozlabs.ibm.com>
Date: Sat, 20 May 2006 08:33:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: Cell and new CPU feature bits
In-Reply-To: <20060519161822.GL8220@pb15.lixom.net>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<200605191211.18737.arnd@arndb.de>
	<20060519161822.GL8220@pb15.lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> (My patch to rename the existing POWER* bits to ARCH_2_* wasn't picked
> up, I'll resend)

The problem is that those names are now part of the API.  I'll need an
ack from the glibc developers before I apply your patch to change them.

Paul.
