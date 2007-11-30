Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B1E0CDDEB9
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 22:43:39 +1100 (EST)
Message-ID: <474FF776.1060803@ru.mvista.com>
Date: Fri, 30 Nov 2007 14:43:50 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
	<20071127212222.GB10829@lixom.net>
	<200711272233.00456.arnd@arndb.de>
	<20071128154904.GA20722@localhost.localdomain>
	<474D9327.9020305@ru.mvista.com> <20071129005440.GA2235@zarina>
	<474FE332.8080103@ru.mvista.com>
	<20071130105849.GA10840@localhost.localdomain>
In-Reply-To: <20071130105849.GA10840@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olof Johansson <olof@lixom.net>, cbou@mail.ru, linux-ide@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

>>>Remaining question: any preferred name for that property? pio-mode okay?
>>>It's assuming that PIO6 capable bus supports PIO0 as well, thus no mask.

>>   I've already suggested "generic". A name "simple" also comes to my mind.

> You've misread my question. I didn't ask about driver name, but pio-mode
> property.

    Probably "max-pio-mode" is a better variant.

MBR, Sergei
