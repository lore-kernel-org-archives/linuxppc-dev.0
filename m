Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 908E9DDEC9
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 16:59:52 +1100 (EST)
Message-ID: <45B5A44E.9020703@garzik.org>
Date: Tue, 23 Jan 2007 00:59:42 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 2.6.20-rc5 1/7] ehea: Fixed wrong dereferencation
References: <200701221252.20814.osstklei@de.ibm.com>
In-Reply-To: <200701221252.20814.osstklei@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Stefan Roscher <roscher@de.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Marcus Eder <meder@de.ibm.com>,
	Stefan Roscher <ossrosch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas Klein wrote:
> Not only check the pointer against 0 but also the dereferenced value
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>
> ---
> 
> 
>  drivers/net/ehea/ehea.h      |    2 +-
>  drivers/net/ehea/ehea_main.c |    6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

applied 1-7 to #upstream-fixes
