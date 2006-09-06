Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6542C67BE7
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 01:22:27 +1000 (EST)
Message-ID: <44FEE7A8.1050904@garzik.org>
Date: Wed, 06 Sep 2006 11:22:16 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
References: <200609041237.46528.ossthema@de.ibm.com>
	<20060904201606.GA24386@electric-eye.fr.zoreil.com>
	<200609042311.21202.arnd@arndb.de>
In-Reply-To: <200609042311.21202.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Francois Romieu <romieu@fr.zoreil.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> Am Monday 04 September 2006 22:16 schrieb Francois Romieu:
>>> +#include "ehea.h"
>>> +#include "ehea_qmr.h"
>>> +#include "ehea_phyp.h"
>> Afaik none of those is included in this patch nor in my 2.6.18-git tree.
> 
> 
> They are in 5, 3 and 2, respectively
> 
>> Happy bissect in sight.
> 
> The driver should get merged as a single commit anyway, even
> if split diffs are posted for review. Even if it gets merged
> like this, bisect will work since the Kconfig option is added
> in the final patch.

That's impossible, in the form they were submitted...
