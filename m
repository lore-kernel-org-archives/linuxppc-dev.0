Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch] powerpc: remove do-nothing cpu setup routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <445BE72D.3050205@am.sony.com>
References: <445BE72D.3050205@am.sony.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 08:31:35 +1000
Message-Id: <1147041095.4777.170.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-05-05 at 17:00 -0700, Geoff Levand wrote:
> Removes the processor specific do-nothing routines __setup_cpu_power3 and
> __setup_cpu_power4 with the generic routine __setup_cpu_null.

Why not just change the caller to test for NULL ?

Cheers,
Ben.
