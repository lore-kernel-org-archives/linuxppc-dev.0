Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68CC4DDED7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 08:22:00 +1000 (EST)
Message-ID: <484EFE82.6080003@garzik.org>
Date: Tue, 10 Jun 2008 18:21:54 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH][2.6.26] ehea: set mac address fix
References: <200806091617.38396.ossthema@de.ibm.com>
In-Reply-To: <200806091617.38396.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, hering2@de.ibm.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> eHEA has to call firmware functions in order to change the mac address
> of a logical port. This patch checks if the logical port is up
> when calling the register / deregister mac address calls. If the port
> is down these firmware calls would fail and are therefore not executed.
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

applied
