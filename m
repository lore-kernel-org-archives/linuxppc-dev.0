Return-Path: <j.lu@tiesse.com>
Received: from tiesse.com (studiogesan.it [193.76.202.5])
	by ozlabs.org (Postfix) with ESMTP id 1030A679E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Jun 2005 22:03:20 +1000 (EST)
Date: Wed, 22 Jun 2005 14:06:12 +0200
Message-Id: <200506221406.AA26215310@tiesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jianliang Lu" <j.lu@tiesse.com>
To: "Jordan, Kyle"  <kylej@aiinet.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: isp1362 usb driver 
Reply-To: j.lu@tiesse.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jordan,
yes I would be really, really gratefully if you could send me the 
source.

The adsl modem we are using is a eagle chipset modem, based on 
eagle-usb project. The modem could be Sagem or aethra on ADI eagle 
chipset.

Best regards,
Jianliang Lu
 
---------- Original Message ----------------------------------
From: "Jordan, Kyle" <kylej@aiinet.com>
Date: Wed, 22 Jun 2005 07:40:44 -0400

>Jianliang Lu,
>
>> the device is a adsl modem, it works correctly in other linux 
>> systems with kernel 2.4.2x. The problem is that the isp1362 
driver 
>> seems that supports only isochronous endpoints. We are 
>> implementing the code to support also control/bulk/interrupt 
>> endpoints.
>
>	I had similar issues with control/bulk/interrupt endpoints 
with
>the ISP1362 host controller driver from DENX.  I went ahead and 
added
>better support for control/bulk/interrupt endpoints.  I could 
send you a
>copy of the source if you like.  The driver is being used on an 
MPC880,
>with the 2.4.21 kernel.  Also, what ADSL modem are using?  We are
>looking into a solution requiring an ADSL modem and the one you 
are
>using may be a good solution for us also.
>
>- Kyle
>
>
>
                   
