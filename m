Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1ED2C67B59
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 02:46:33 +1000 (EST)
In-Reply-To: <44D21AFA.2010900@ru.mvista.com>
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>	<9C1B15CC-6984-433D-8A1E-F856567B1AD2@kernel.crashing.org>	<1154549483.19994.46.camel@cashmere.sps.mot.com>	<BFD18279-7617-4F50-BB22-21A46C65FD50@kernel.crashing.org>	<1154550970.19994.57.camel@cashmere.sps.mot.com>
	<F4FA8DDC-0490-4792-8B9B-89D3F0AECF26@kernel.crashing.org>
	<44D21AFA.2010900@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4644A4A2-0A49-45A8-AAFD-67647AB44EB8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
Date: Thu, 3 Aug 2006 11:46:33 -0500
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 3, 2006, at 10:49 AM, Sergei Shtylyov wrote:

> Hello.
>
> Kumar Gala wrote:
>> Here is the code modification to fsl_soc.c, I'm sure we can get  
>> this  fixed push into 2.6.18 if desired.
>
>> if(mac_addr = get_property(np, "address", NULL))
>>    memcpy(gfar_data.mac_addr, mac_addr, 6);
>> if(mac_addr = get_property(np, "local-mac-address", NULL);
>>    memcpy(gfar_data.mac_addr, mac_addr, 6);
>
>    BTW, doesn't it also have sense to convert gianfar.c to using  
> of_device instead of platform_device?

We can't do that until all consumers from arch/ppc are gone.

- k
