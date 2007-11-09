Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4F32ADDEEC
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 00:36:21 +1100 (EST)
Date: Fri, 9 Nov 2007 16:33:50 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 0/5] fixups for mpc8360 rev. 2.1 erratum #2 (RGMII Timing)
Message-ID: <20071109133350.GB21232@localhost.localdomain>
References: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	Li Yang <leoli@freescale.com>, jgarzik@pobox.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 05, 2007 at 12:15:30PM -0600, Kim Phillips wrote:
> Hello all,
> 
> the following patches fix RGMII timing for rev. 2.1 of the mpc8360,
> according to erratum #2 (erratum text included below).  Basically the
> most intrusive part is the addition of two new RGMII Internal Delay
> modes; one for TX delay only, and the other for RX delay only (i.e, not
> both at the same time).
> 
> Please review, and since this affects both netdev and powerpc trees,
> one maintainer should ack them for the other to push upstream (i.e,
> Kumar acks them, and Leo picks them up to go through netdev or the
> other way around; either way is fine with me).  I'm hoping they're
> trivial enough to go in 2.6.24.

All five patches are

Tested-by: Anton Vorontsov <avorontsov@ru.mvista.com>


Let's hope they'll hit 2.6.24.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
