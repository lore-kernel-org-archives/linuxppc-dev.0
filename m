Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD47367B8C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 23:48:53 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GBXNF-00013m-9y
	for linuxppc-embedded@ozlabs.org; Fri, 11 Aug 2006 15:48:33 +0200
Received: from rusfw02.rohde-schwarz.com ([80.246.32.40])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 11 Aug 2006 15:48:29 +0200
Received: from euphoria by rusfw02.rohde-schwarz.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 11 Aug 2006 15:48:29 +0200
To: linuxppc-embedded@ozlabs.org
From: Florian Boelstler <euphoria@arcor.de>
Subject: Re: MPC8548 PCIe / PCI support with BSP MPC8548CDS 02/24/2006
Date: Fri, 11 Aug 2006 15:48:12 +0200
Message-ID: <ebi1qo$dcp$1@sea.gmane.org>
References: <3140C9D90FB6D911ABD7000F206DC92603D6E0FC@zhk08exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <3140C9D90FB6D911ABD7000F206DC92603D6E0FC@zhk08exm40.ap.freescale.net>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jeffrey,

I got one more question.
Is it enough to jumper the MPC8548 to an endpoint device?
Or is some additional code required (like your U-Boot commands) to make 
a MPC8548 work as an EP.
Up to now I was assuming there is a certain EEPROM that contains a 
sufficient PCIe EP configuration.

Thanks,

   Florian
