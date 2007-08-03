Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6B3EDDE07
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 22:35:44 +1000 (EST)
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200708031425.19475.sr@denx.de>
References: <20070730151628.GA5100@ru.mvista.com>
	<200708030844.13895.sr@denx.de> <46B31352.1060503@ru.mvista.com>
	<200708031425.19475.sr@denx.de>
Content-Type: text/plain
Date: Fri, 03 Aug 2007 22:35:36 +1000
Message-Id: <1186144536.5981.5.camel@gruick>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Depends on interpretation. IIRC currently the same die is used for 440EPx and 
> 440GRx. I could be wrong here though and it is just a bug in the chip. But 
> anyway we should support this somehow. Could be that I missed this in the 
> current 440GRx (Rainier) arch/ppc support too. I have to admit, that no 
> clever solution comes to my mind right away though.

We can always come up with some kind of runtime detection, by turning on
MSR:FP, issuing an fp instruction and catching the illegal instruction
fault if any :-)

Ben.
