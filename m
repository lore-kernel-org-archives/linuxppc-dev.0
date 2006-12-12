Return-Path: <tnt@246tNt.com>
Received: from outmx023.isp.belgacom.be (outmx023.isp.belgacom.be
	[195.238.4.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D5A667C5F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Dec 2006 06:24:09 +1100 (EST)
Received: from outmx023.isp.belgacom.be (localhost [127.0.0.1])
	by outmx023.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBCJO4Ha003931
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Dec 2006 20:24:04 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <457F0193.9040007@246tNt.com>
Date: Tue, 12 Dec 2006 20:22:59 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: "Pedro Luis D. L." <carcadiz@hotmail.com>
Subject: Re: Lite5200B I2S driver
References: <BAY122-F11E9828E7994B0E0514B19CAD70@phx.gbl>
In-Reply-To: <BAY122-F11E9828E7994B0E0514B19CAD70@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Pedro Luis D. L. wrote:
> Hi all,
>
> I´m working with a Lite5200B EVB, trying to atach an audio output to a PCM 
> 1680 from Texas Instruments.
> At this moment I am using the patched 2.6.16.11-rt18 kernel that comes with 
> Freescale BSP.
> I´ve tried to develop an I2S driver for the platform with no results. I´m 
> afraid that my driver devolping skills are still too low.
>
> Anybody knows a working I2S driver for this board that can throw any 
> audiooutput through PSCs?
>
> Any help or indication would be apreciated
I've never seen one.

I'm currently working on a AC97 driver, maybe once it's done you can use
it as a base.
It's pretty early so don't excepect anything before a while ;)

I'm pretty sure some part could be shared between the two ...


    Sylvain
