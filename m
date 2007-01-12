Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B137DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:47:04 +1100 (EST)
In-Reply-To: <17831.7374.149397.133454@cargo.ozlabs.ibm.com>
References: <32F3CC26D4DAC44E8ECD07155727A46E8169E3@zch01exm20.fsl.freescale.net>
	<17831.7374.149397.133454@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B8622DA-17D0-4232-954F-B72C1FCC0300@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Thu, 11 Jan 2007 23:46:15 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 11, 2007, at 11:29 PM, Paul Mackerras wrote:

> Zhu Ebony-r57400 writes:
>
>> This series of patch add support to fully comply with IEEE-754  
>> standard
>> for E500/E500v2 core when hardware floating point compiling is used.
>
> Your patch descriptions need to explain in detail in what way the
> current code doesn't comply with the IEEE-754 standard, and what
> approach you have taken to make it comply.  If there are alternative
> approaches, explain why the approach you have taken is the best.
>
> Thanks,
> Paul.

In addition, this is something that we need to know how it was tested  
for IEEE-754 compliance.

- k
