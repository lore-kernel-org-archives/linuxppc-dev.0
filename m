Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8412FDE0E5
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 03:50:59 +1100 (EST)
Message-ID: <47BC5A62.2030701@garzik.org>
Date: Wed, 20 Feb 2008 11:50:42 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH] ehea: add kdump support
References: <47B30A49.8080404@de.ibm.com>
In-Reply-To: <47B30A49.8080404@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas Klein wrote:
> This patch adds kdump support to the ehea driver. As the firmware doesn't free
> resource handles automatically, the driver has to run an as simple as possible
> free resource function in case of a crash shutdown. The function iterates over
> two arrays freeing all resource handles which are stored there. The arrays are
> kept up-to-date during normal runtime. The crash handler fn is triggered by the
> recently introduced PPC crash shutdown reg/unreg functions.
> 
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>
> 
> ---
>  drivers/net/ehea/ehea.h      |   34 +++++-
>  drivers/net/ehea/ehea_main.c |  281 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 290 insertions(+), 25 deletions(-)

applied
