Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D6E7A68A86
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 07:36:11 +1100 (EST)
Message-ID: <43D7E0BA.7020307@ovro.caltech.edu>
Date: Wed, 25 Jan 2006 12:34:02 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Yosemite/440EP is there a global interrupt enable mask?
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu>
	<43D67AF6.6070403@ovro.caltech.edu> <200601251128.05370.sr@denx.de>
	<43D7C3C6.8020709@ovro.caltech.edu>
	<20060125185518.GB7425@gate.ebshome.net>
	<43D7D5A1.70704@ovro.caltech.edu>
	<20060125201320.GB19460@gate.ebshome.net>
In-Reply-To: <20060125201320.GB19460@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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



> DO NOT access UIC registers directly. DO NOT.

Okay :)

> Nothing that can be of interest for a general public. They are 
> board-specific (lots of bit-banging SPI stuff). All other drivers I 
> wrote are already in public tree.

With regard to SPI drivers. Has the 2.6 kernel implemented
an SPI 'bus' interface (like PCI, OCP, etc). The 440EP also
has an SPI interface that I plan to look at.

The custom boards will need temperature sensing and other
monitoring jobs. I want to see what kind of overhead both
the I2C and SPI bus require. If its too much, then I'll
move those tasks out into an FPGA FSM.

The PowerPC's main job will be reading FPGA data every 1ms,
int-to-float conversions, FFT, and accumulation.

Cheers
Dave
