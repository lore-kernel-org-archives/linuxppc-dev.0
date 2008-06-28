Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A46CDDFCE
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 15:13:13 +1000 (EST)
Date: Sat, 28 Jun 2008 14:10:27 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: monstr@seznam.cz
Subject: Re: [PATCH 59/60] microblaze_v4: syscall_table.S and unistd.h
Message-ID: <20080628051027.GJ25492@linux-sh.org>
References: <1214483429-32360-51-git-send-email-monstr@seznam.cz>
	<1214483429-32360-52-git-send-email-monstr@seznam.cz>
	<1214483429-32360-53-git-send-email-monstr@seznam.cz>
	<1214483429-32360-54-git-send-email-monstr@seznam.cz>
	<1214483429-32360-55-git-send-email-monstr@seznam.cz>
	<1214483429-32360-56-git-send-email-monstr@seznam.cz>
	<1214483429-32360-57-git-send-email-monstr@seznam.cz>
	<1214483429-32360-58-git-send-email-monstr@seznam.cz>
	<1214483429-32360-59-git-send-email-monstr@seznam.cz>
	<1214483429-32360-60-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1214483429-32360-60-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 02:30:28PM +0200, monstr@seznam.cz wrote:
> +#define __NR_semtimedop		325
> +#define __NR_timerfd_settime	326
> +#define __NR_timerfd_gettime	327
> +
> +#ifdef __KERNEL__
> +
> +#define __NR_syscalls		327
> +
Off-by-1 on __NR_syscalls, this should be 328.
