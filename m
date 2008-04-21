Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63A78DE2F6
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 23:58:13 +1000 (EST)
Message-ID: <480C9D38.3020902@semihalf.com>
Date: Mon, 21 Apr 2008 15:57:12 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] 52xx: defconfigs for CM5200, Lite5200B,
	Motion-PRO and TQM5200
References: <20080415103635.9629.55344.stgit@pollux.denx.de>
In-Reply-To: <20080415103635.9629.55344.stgit@pollux.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bartlomiej Sieka wrote:
> Board-specific defconfigs based on current mpc5200_defconfig, archival
> lite5200_defconfig, and [cm5200|motionpro|tqm5200]_defconfig from the
> linux-2.6-denx tree. Kernels build using these defconfigs were verified
> to boot with root filesystem mounted over NFS on Motion-PRO, TQM5200
> and Lite5200B boards. CM5200 target was not tested due to hardware
> unavailability.

Hello Grant,

There hasn't been any negitve comments on the above patch -- will you
push it upstream via your tree?

Regards,
Bartlomiej
