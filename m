Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4992ADE342
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 06:50:57 +1000 (EST)
Message-Id: <1C9DCC84-DA28-4649-BB26-19774A6569F2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <4898BCD3.5050703@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH add immr alias 1/4] powerpc: Teach get_immrbase to use
	immr alias if it exists.
Date: Tue, 5 Aug 2008 15:50:33 -0500
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
	<200808052243.24001.arnd@arndb.de> <4898BCD3.5050703@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 5, 2008, at 3:49 PM, Scott Wood wrote:

> Arnd Bergmann wrote:
>> On Tuesday 05 August 2008, John Rigby wrote:
>>> This will allow the eventual removal of device_type = "soc"
>>> properties in soc nodes.
>> Stupid question, but why not remove immrbase instead?
>> It seems that all users can be converted to use a reg
>> property of some actual device instead of making assumptions
>> about the register layout of the whole SOC.
>
> That wouldn't eliminate the need for the alias, though -- u-boot  
> needs to find the node to fill in properties.

While I have no issue with the change.  I'm interested to see how John  
plans on using this in u-boot.

- k
