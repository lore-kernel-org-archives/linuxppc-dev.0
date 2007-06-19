Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7CF83DDF55
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 02:18:26 +1000 (EST)
Message-ID: <467801CA.4090907@freescale.com>
Date: Tue, 19 Jun 2007 11:18:18 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.23 branch in powerpc.git created
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>	<Pine.LNX.4.60.0706151915580.5979@poirot.grange>	<4672D694.5060701@freescale.com>
	<18039.30713.948665.48880@cargo.ozlabs.ibm.com>
In-Reply-To: <18039.30713.948665.48880@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
>>I assume you mean "Call of_register_i2c_devices() for fsl-i2c"
>>(http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036333.html)?
> 
> 
> Isn't that the one where you replied to yourself saying you'd posted
> the wrong patch?  Did you ever post the right patch?

I did, but discussion ensued, and the consensus was that the original 
patch is the way to do it.

-Scott
