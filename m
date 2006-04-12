Return-Path: <tnt@246tNt.com>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E7BA67BBF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 08:30:27 +1000 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k3CMUH68030339
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Apr 2006 00:30:18 +0200
	(envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.131] (181-88.244.81.adsl.skynet.be [81.244.88.181])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k3CMUGMb030334
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Apr 2006 00:30:16 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <443D7F78.30402@246tNt.com>
Date: Thu, 13 Apr 2006 00:30:16 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: freescale lite 5200 board and kernel 2.6
References: <20060405210654.GA16848@raptus.dandreoli.com>	<20060405212741.GC61331@server.idefix.loc>	<20060406221056.GA15540@raptus.dandreoli.com>	<20060408082100.GA54030@server.idefix.loc>
	<20060410215428.GA22290@raptus.dandreoli.com>
In-Reply-To: <20060410215428.GA22290@raptus.dandreoli.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Domenico Andreoli wrote:
> On Sat, Apr 08, 2006 at 10:21:00AM +0200, Matthias Fechner wrote:
>   
>> Hello Domenico,
>>     
>
> Hello Matthias,
>
>   
>> * Domenico Andreoli <cavokz@gmail.com> [07-04-06 00:10]:
>>     
>>> kernel is built following the instructions on your wiki, i attached
>>> the config file. please have a look, let me know if any check/test may
>>> be advised.
>>>       
>> sry, but I have now time to try your kernel config, but I attached
>> mine which is working fine for me.
>> Maybe this helps you.
>>     
>
> unfortunately it does not :/
>
> sometimes kernel prints "eth0: config: auto-negotiation on, 100HDX,
> 10HDX.", the eth0 is up and everything works.
>
> most of the times "eth0: config: auto-negotiation off, No speed/duplex
> selected?." is instead printed and eth0 seems to not exist.
>
> i tend to exclude hw problems, older kernel 2.4.x always succeed in
> using eth0.
>
> is there any way to force eth0 auto-negotiation?
>   
When it doesn't work, did it detect the phy correctly ?
Somewhere in the boot sequence it should print something about a LXT971
being found at some address.


    Sylvain
