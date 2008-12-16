Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40F1F474C2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 05:24:13 +1100 (EST)
Message-Id: <9226B1EC-0DEF-43BB-9051-AE356720A3F5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081205201026.GA19758@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/7] powerpc: Implement get_brgfreq() and get_baudrate()
	stubs
Date: Tue, 16 Dec 2008 12:24:04 -0600
References: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
	<20081205201026.GA19758@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 5, 2008, at 2:10 PM, Anton Vorontsov wrote:

> This is needed to not bother with ugly #ifdefs in the drivers.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/sysdev/fsl_soc.h |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)

applied to next

- k
