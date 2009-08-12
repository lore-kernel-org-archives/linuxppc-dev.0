Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0205AB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 11:43:22 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D6E6DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 11:43:20 +1000 (EST)
Message-Id: <835B2CCF-7189-499F-B0F5-527F2A788A77@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "B.J. Buchalter" <bj@mhlabs.com>
In-Reply-To: <4D3BDC67-986A-482D-BB3F-497F64C68531@mhlabs.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: Problem with PCIe -> PCI bridge on MPC8377E-RDB
Date: Tue, 11 Aug 2009 20:43:13 -0500
References: <4D3BDC67-986A-482D-BB3F-497F64C68531@mhlabs.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 11, 2009, at 5:27 PM, B.J. Buchalter wrote:

>
> So it seems like the XIO2000(A) is being misconfigured or  
> misidentified, and rather than finding the configured bus behind the  
> bridge, it is doing "something else", and as a result, not finding  
> the PCI OHCI FireWire controller on the PCI side of the bridge.
>
> Unfortunately I have no real idea where to start looking at this...
>
> Any ideas? Or is there a better place to be posting about this?

This is a reasonable place to post this.  Can you see what u-boot  
reports for its PCI/e bus scan?

- k
