Return-Path: <ivica@asist-traffic.com>
Received: from mta1.siol.net (pegasus.siol.net [193.189.160.40])
	by ozlabs.org (Postfix) with ESMTP id 32C2367A46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 01:43:26 +1100 (EST)
Message-ID: <4236F484.9050301@asist-traffic.com>
Date: Tue, 15 Mar 2005 15:43:16 +0100
From: Babarovic Ivica <ivica@asist-traffic.com>
MIME-Version: 1.0
To: egoforth@gmail.com, linuxppc-embedded@ozlabs.org
References: <4235BD6A.5000004@gmail.com>
In-Reply-To: <4235BD6A.5000004@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: I2C RTC recommendations?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ed Goforth wrote:

> I'm looking to add a RTC to a custom 440gx-based board.  The board
> developer has indicated that they would prefer use an I2C device (vs.
> eg. something like the DS1743 that's on the reference board).

I got my board equipped with Epson's RX-8025 SA/NB RTC module.
I managed to get it working with a few hacks to a 8564 RTC driver
from  Stefan Eletzhofer This RTC module is also from Epson.
So far everything works fine. I don't really know why board designers
decided for it but I suppose the main concern was price.  :D

regards,
Ivica
