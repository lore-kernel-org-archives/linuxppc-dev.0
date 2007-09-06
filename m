Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96D5CDDF1F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:42:09 +1000 (EST)
In-Reply-To: <20070906140940.GA3947@powerlinux.fr>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<20070905024805.GE17189@localhost.localdomain>
	<20070905115419.321990@gmx.net>
	<007113bd4008c022872fae697d5dd20f@kernel.crashing.org>
	<20070906140940.GA3947@powerlinux.fr>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6dc612309c6f2d6ed3fa8e14764dd085@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Date: Thu, 6 Sep 2007 16:42:01 +0200
To: Sven Luther <sven@powerlinux.fr>
Cc: David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> The node should have a compatible
>>>> property which is sufficient to select the right bridge driver.
>>> Yeah, I defined a compatible = "mai,articias"; property in the pci
>>> node.
>>> Are there any naming conventions (maybe lower case only)?
>>
>> It's conventional for the part behind the comma to be lower-case
>> only, yes.  There are more stringent rules for the part before
>> the comma (the manufacturer part).  What is "mai"?
>
> mai logic (some mentor arc derivative i think, ma stands for mentor 
> arc)
> was the firm who produced the articia northbridge.

It should either be "00009D2,articia-s" (using the OUI) or
"mai-logic,articia-s", then.

> The Articia S
> northbridge was known to be defective, and i am unsure if mai survived
> it or something.

It seems they didn't.


Segher
