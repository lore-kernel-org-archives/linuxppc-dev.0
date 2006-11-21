Return-Path: <olof@lixom.net>
Date: Tue, 21 Nov 2006 10:58:43 -0600
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/22] powerpc: convert idle_loop to use hard_irq_disable()
Message-ID: <20061121105843.6b270283@pb15>
In-Reply-To: <200611211114.46305.arnd@arndb.de>
References: <20061120174454.067872000@arndb.de>
	<20061120180520.418063000@arndb.de>
	<1164070425.8073.40.camel@localhost.localdomain>
	<200611211114.46305.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 21 Nov 2006 11:14:45 +0100 Arnd Bergmann <arnd@arndb.de> wrote:

> IIRC, all new CPUs are supposed to use the same mechanism based on the
> 0x100 vector.

It's only really affecting platforms without hypervisors though, which
aren't all that many (yet).

I don't have a problem dealing with it locally in my platform.


-Olof
