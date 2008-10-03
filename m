Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBC05DDFED
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 07:55:13 +1000 (EST)
Message-Id: <3332E78F-1877-4F48-8387-C199A196AC14@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081003194036.GA9323@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/QE: move QE_GPIO Kconfig symbol into the
	platforms/Kconfig
Date: Fri, 3 Oct 2008 16:55:01 -0500
References: <1222961277-6166-1-git-send-email-timur@freescale.com>
	<20081003070416.GA460@oksana.dev.rtsoft.ru>
	<E50C84D1-E250-4827-B260-A5005CABE959@kernel.crashing.org>
	<20081003084849.GA18271@oksana.dev.rtsoft.ru>
	<20081003090804.GA29029@oksana.dev.rtsoft.ru>
	<48E63DB6.8030102@freescale.com>
	<20081003160545.GA29927@oksana.dev.rtsoft.ru>
	<48E643A5.9060403@freescale.com>
	<20081003162317.GA31740@oksana.dev.rtsoft.ru>
	<B88B23CE-9EBD-4C4B-9978-0E9C3C3AB738@kernel.crashing.org>
	<20081003194036.GA9323@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2008, at 2:40 PM, Anton Vorontsov wrote:

> Specifying user-selectable option in the qe_lib/Kconfig was a bad idea
> because the qe_lib/Kconfig is included into the top level Kconfig, and
> thus the QE_GPIO option appears at the top level menu.
>
> This patch effectively moves the QE_GPIO option under the platform  
> menu
> instead.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> On Fri, Oct 03, 2008 at 12:48:31PM -0500, Kumar Gala wrote:
> [...]
>> I want to leave the "hidden" options in qe_lib/Kconfig.. just move  
>> the
>> user selectable one (QE_GPIO) in to platforms/Kconfig
>
> Here it is.
>
> arch/powerpc/platforms/Kconfig     |    9 +++++++++
> arch/powerpc/sysdev/qe_lib/Kconfig |    9 ---------
> 2 files changed, 9 insertions(+), 9 deletions(-)

applied

- k
