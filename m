Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 17FA0DDE99
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 05:11:14 +1000 (EST)
Message-ID: <46C4A146.6090701@garzik.org>
Date: Thu, 16 Aug 2007 15:11:02 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
References: <200707092304.l69N4Ggd023137@harpo.it.uu.se>
In-Reply-To: <200707092304.l69N4Ggd023137@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: dwm@enoyolf.org, linux-ide@vger.kernel.org, bahadir.balban@gmail.com,
	linuxppc-dev@ozlabs.org, albertl@mail.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mikael Pettersson wrote:
> (cc:ing linuxppc-dev)
> 
> On Tue, 26 Jun 2007 13:43:15 +0800, Albert Lee wrote:
>> Recently the PLL input clock of pata_pdc2027x is sometimes detected
>> higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
>> It seems sometimes the mdelay() function is not as precise as it
>> used to be. Per Alan's advice, HT or power management might affect
>> the precision of mdelay().
>>
>> This patch calls gettimeofday() to mesure the time elapsed and
>> calculate the PLL input clock accordingly.
> 
> Unfortunately this breaks pata_pdc2027x on my PowerMac G3:

Did this ever get resolved?

	Jeff
