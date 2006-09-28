Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id EE89C67BC8
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 06:53:26 +1000 (EST)
Message-ID: <451C3641.60107@ru.mvista.com>
Date: Fri, 29 Sep 2006 00:53:21 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
References: <A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>	<1158787957.6002.307.camel@localhost.localdomain>	<20060920215738.GC24809@mag.az.mvista.com>	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>	<20060921133707.GA29137@gate.crashing.org>	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>	<20060922012408.GA13820@mag.az.mvista.com>	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>	<20060922185923.GB25738@mag.az.mvista.com>	<74E4B2E4-B59C-4998-B9FC-A77245C6AF6B@kernel.crashing.org>	<20060923081836.GA25298@mag.az.mvista.com>
	<D47FC822-2AB1-459A-B2EC-50A99552DC9A@kernel.crashing.org>
In-Reply-To: <D47FC822-2AB1-459A-B2EC-50A99552DC9A@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Matt Porter <mporter@embeddedalley.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Segher Boessenkool wrote:

>>>Yes.  Except a "cell" is not what you think it is.  A "cell" is the
>>>size of numbers OF deals with internally; just deal with it.  Of
>>>course, there's things like "#address-cells", which really mean
>>>"#-32bit-things-per-address".

>>Okay, well, when I talked about cells I meant "#-32bit-things-per- 
>>address".
>>Obviously it was silly of me to think that "#address-cells" meant  
>>the # of
>>address cells...

> Some background might clear things up (or not)...  A "cell" is the
> unit of data in a Forth system.  When OF was young (and not yet
> called OF), all systems were 32-bit, and the 32-bit-thingies in
> the properties (which weren't yet called properties) in the device
> tree were called cells as well.  When 64-bit came into the picture,
> everything fell apart.  The "correct" name for the property thingies
> now is "integers as encoded with encode-int".

    I looked into the OF 64-bit extensions spec, and "cell" is 64-bit there.
So, "address" should look valid. I don't know whether PPC64 boxes support 
64-bit OF, or only 32-bit, however, the kernel doesn't seem to deal with 
64-bit ones correctly, so I'm assuming that 32-bit OF is at least available...
    Anyway, I'm still missing the point of not using "address" which is 
clearly intended for such case.

WBR, Sergei
