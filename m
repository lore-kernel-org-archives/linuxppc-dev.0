Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
Date: Wed, 4 Apr 2007 00:55:35 +0200
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<1175636904.10567.8.camel@shinybook.infradead.org>
	<4612D8FE.1070400@am.sony.com>
In-Reply-To: <4612D8FE.1070400@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704040055.36173.arnd@arndb.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	David Woodhouse <dwmw2@infradead.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 April 2007, Geoff Levand wrote:
> So there are really two answers, one is that having the boot memory in the
> DT hasn't changed, I just haven't finished that part yet. =A0The other is=
 that
> we get the amount of memory at runtime because it is a dynamic resource, =
and
> cannot be known at DT compile time.

But the device tree can easily be modified before entering the new kernel,
when the kboot kernel allocates all the memory it can get, it just needs
to list it in the device tree in some preallocated device node.

	Arnd <><
