Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E826DDF2D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 07:11:56 +1000 (EST)
Message-ID: <4845B382.20205@garzik.org>
Date: Tue, 03 Jun 2008 17:11:30 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 2/3] [2.6.26] ehea: Add dependency to Kconfig
References: <200805071443.20192.hannes.hering@linux.vnet.ibm.com>	
	<20080528164405.GA4836@localdomain>	
	<200806031007.40162.hannes.hering@linux.vnet.ibm.com>	
	<20080603204908.GB7475@localdomain>
	<1212527335.23656.2.camel@badari-desktop>
In-Reply-To: <1212527335.23656.2.camel@badari-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, themann@de.ibm.com,
	Hannes Hering <hannes.hering@linux.vnet.ibm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Nathan Lynch <ntl@pobox.com>, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty wrote:
>> It would be nice to get this resolved for 2.6.26 -- this new
>> dependency causes working 2.6.25 configs to effectively fail (by
>> deselecting CONFIG_EHEA during make oldconfig).


When everybody else is happy, I'm happy :)
