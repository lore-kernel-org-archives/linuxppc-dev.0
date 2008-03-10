Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AD71DDF4D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 01:40:08 +1100 (EST)
Message-Id: <EDCBAD9F-B469-4448-B5E0-4B8806519C63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <1204934343-5235-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH v2] Make 83xx perfmon support selectable
Date: Mon, 10 Mar 2008 09:39:27 -0500
References: <1204934343-5235-1-git-send-email-afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 7, 2008, at 5:59 PM, Andy Fleming wrote:

> Not all e300 cores support the performance monitors, and the ones
> that don't will be confused by the mf/mtpmr instructions.  This
> allows the support to be optional, so the 8349 can turn it off
> while the 8379 can turn it on.  Sadly, those aren't config options,
> so it will be left to the defconfigs and the users to make that
> determination.
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
>
> Ugh.  The previous version was a little hasty.  Needed to base off
> PPC_83xx rather than 83xx
>
> arch/powerpc/platforms/Kconfig         |    1 -
> arch/powerpc/platforms/Kconfig.cputype |    7 ++++++-
> 2 files changed, 6 insertions(+), 2 deletions(-)

applied.

- k
