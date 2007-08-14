Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B9F0DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 04:00:17 +1000 (EST)
Message-ID: <46C1EDAA.3070402@freescale.com>
Date: Tue, 14 Aug 2007 13:00:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: joe.hamman@embeddedspecialties.com
Subject: Re: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be configurable
References: <1187044669.10295.4.camel@server>	<3FE16C0A-892F-4481-999A-A699C0C70BF9@kernel.crashing.org>	<013b01c7de23$5baa7d70$6f00a8c0@ESIDT>
	<1B668DF2-9909-4D43-AAFF-3A2ADFA283B2@freescale.com>
	<46C1D553.4000201@freescale.com>
	<018801c7de93$43390e80$6f00a8c0@ESIDT>
In-Reply-To: <018801c7de93$43390e80$6f00a8c0@ESIDT>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Joe Hamman wrote:
> 		ethernet@24000 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			device_type = "network";
> 			model = "eTSEC";
> 			compatible = "gianfar";
> 			reg = <24000 1000>;
> 			mac-address = [ 00 E0 0C 00 73 00 ];
> 			interrupts = <1d 2 1e 2 22 2>;
> 			interrupt-parent = <&mpic>;
> 			phy-handle = <&phy1f>;
> 			tbi-handle = <&tbi1e>;
> 		};

Is any given board going to have at runtime (i.e. not jumper selectable) 
  both a phy and a tbi (I'm not very familiar with the latter, so I 
apologize if this is a dumb question).  If not, I'd stick with 
phy-handle and have something in the phy node to indicate that it's tbi.

-Scott
