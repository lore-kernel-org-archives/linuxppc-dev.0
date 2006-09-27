Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BAD267B92
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 08:30:11 +1000 (EST)
Message-ID: <451AFB6A.9010706@garzik.org>
Date: Wed, 27 Sep 2006 18:30:02 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2.6.19-rc1] ehea firmware interface based on
	Anton	Blanchard's new hvcall interface
References: <200609271847.34258.ossthema@de.ibm.com>	<451AF29D.2030102@garzik.org>
	<17690.63978.373862.727933@cargo.ozlabs.ibm.com>
In-Reply-To: <17690.63978.373862.727933@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, pmac@au1.ibm.com,
	Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Jeff,
> 
>>> This eHEA patch reflects changes according to Anton's new hvcall interface
>>> which has been commited in Paul's git tree:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
>> When is this going upstream?  I don't want things to get too out-of-sync.
> 
> It's upstream already, and currently the ehea driver in Linus' tree
> doesn't compile as a result.

Thanks for the clarification.  The original quoted text sorta implied 
the opposite.

	Jeff
