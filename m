Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80444DDF82
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 12:06:27 +1100 (EST)
Message-ID: <45E8CA09.9030104@garzik.org>
Date: Fri, 02 Mar 2007 20:06:17 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 1/2] ehea: dynamic add / remove port
References: <200702281834.02990.ossthema@de.ibm.com>
In-Reply-To: <200702281834.02990.ossthema@de.ibm.com>
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
> This patch introduces functionality to dynamically add / remove
> ehea ports via an userspace DLPAR tool. It creates a subnode for
> each logical port in the sysfs. 
> 
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

applied 1-2 to #upstream (2.6.22)

your patches added much trailing whitespace.  please fix.
