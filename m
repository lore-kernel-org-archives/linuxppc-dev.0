Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40D0767F3C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 03:51:26 +1000 (EST)
Message-ID: <4300D619.5020106@varma-el.com>
Date: Mon, 15 Aug 2005 21:51:21 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
References: <43006FD4.6060801@varma-el.com> <43009A8D.1040704@246tNt.com>
	<4300AF41.9000807@varma-el.com>
	<20050815171637.GA20943@xyzzy.farnsworth.org>
In-Reply-To: <20050815171637.GA20943@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [00/02] MPC5200 Bestcomm platform driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Dale Farnsworth wrote:
> On Mon, Aug 15, 2005 at 03:05:37PM +0000, Andrey Volkov wrote:
> 
>>Sylvain Munaut wrote:
>>
>>>Obviously I haven't yet had the time to review all the code but the
>>>glance I had looked good ! I'll review it deeper and test it and come
>>>back to you asap.
>>
>>As you could see it was only first step (I hope at not so long way :)):
>>bring Dale's code to the current kernel, and make point from which
>>everyone could start dance.
> 
> 
> Andrey, thanks for keeping this alive.
> 
> I agree with Sylvain's other comments.
> 
> The main thing I would like to see happen to this driver (other
> than getting it in mainline :-) is an attempt to replace the
> ugly phy code with calls to the new phy abstraction layer.
> On the other hand, I'm glad to see progress on any front.
Ok. But if smb, wish do it now -- welcome.
Because I planned do it only after bestcomm will be accepted.

-- 
Regards
Andrey Volkov
