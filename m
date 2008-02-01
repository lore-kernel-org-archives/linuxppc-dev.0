Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7429EDE121
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 05:40:52 +1100 (EST)
Message-ID: <47A367AE.8000004@garzik.org>
Date: Fri, 01 Feb 2008 13:40:46 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH] ehea: fix sysfs link compile problem
References: <200802011537.42578.ossthema@de.ibm.com>
In-Reply-To: <200802011537.42578.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> Due to changes in the struct device_driver there is no direct
> access to its kobj any longer. The kobj was used to create
> sysfs links between eHEA ethernet devices and the driver.
> This patch removes the affected sysfs links to resolve
> the build problems.
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> 
> ---
>  drivers/net/ehea/ehea_main.c |   37 -------------------------------------
>  1 files changed, 0 insertions(+), 37 deletions(-)

applied
