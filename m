Return-Path: <tnt@246tNt.com>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22694679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Mar 2006 10:02:47 +1100 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k2TN2ehX015045
	for <linuxppc-embedded@ozlabs.org>; Thu, 30 Mar 2006 01:02:40 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <442B11E8.7020107@246tNt.com>
Date: Thu, 30 Mar 2006 01:02:00 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Kernel for MPC Lite 5200 will not compile
References: <20060329201128.2FB713535EE@atlas.denx.de>
In-Reply-To: <20060329201128.2FB713535EE@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

Wolfgang Denk wrote:
> Dear Matthias,
>
> in message <20060329153941.GD95498@server.idefix.loc> you wrote:
>   
>> i tried the following trees:
>> linux-2.6.15 (from kernel.org)
>> linux-2.6-denx (from cg-clone http://www.denx.de/git/<project_name>)
>>     
>
> MPC5200 support known to be broken in these two.
>   
It is ?

I don't know about the 2.6-denx, but the stock 2.6.15 should work just fine.
What's wrong with it ? (except it misses some drivers ... it should compile
and boot just fine)



        Sylvain
