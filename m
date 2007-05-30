Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E79CDDF46
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 00:00:36 +1000 (EST)
Message-ID: <465D8379.3090109@garzik.org>
Date: Wed, 30 May 2007 10:00:25 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Thomas Klein <osstklei@de.ibm.com>
Subject: Re: [PATCH 2.6.22-rc3] ehea: Fixed multi queue RX bug
References: <200705301239.23934.osstklei@de.ibm.com>
In-Reply-To: <200705301239.23934.osstklei@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas Klein wrote:
> Must access the respective queue's dummy netdev instead of the port's netdev.
> 
> Signed-off-by: Thomas Klein <tklein@de.ibm.com>

applied
