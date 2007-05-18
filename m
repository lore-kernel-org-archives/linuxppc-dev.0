Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0756ADDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 03:25:30 +1000 (EST)
Message-ID: <464DDFA5.6050106@freescale.com>
Date: Fri, 18 May 2007 12:17:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
	<464C871C.4090300@freescale.com>
	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
	<20070518171555.543f9bdc@hyperion.delvare>
	<D50C4D36-CEA5-4F7F-8A4C-CC747DF85865@kernel.crashing.org>
	<464DD5E3.1060301@freescale.com>
	<6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
In-Reply-To: <6F8D3143-423D-45FA-9F40-00BF770831F2@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On May 18, 2007, at 11:35 AM, Scott Wood wrote:
> 
>> Kumar Gala wrote:
>>
>>> I guess my gripe is about proposing a solution and not willing to   
>>> extend it in light of people providing issues with it.
>>
>>
>> I'm perfectly willing to extend it if you let me know what you  think 
>> is needed, rather than just saying "switches and muxes".   What 
>> *specifically* would they need beyond what I proposed?
> 
> 
> I provided you an example device and asked you to explain how it  would 
> be described in what you are proposing.

And I did.  What did you find lacking in the device tree fragment I 
suggested?

> I never said don't bother because you didn't cover the switch/mux  
> case.  I said don't bother because I don't see what the value is  
> creating a namespace that no one is going to manage and thus will end  
> up most likely being linux specific, and linux already provides a  
> solution for the problem.

Given that power.org is attempting to do further standardization of the 
device tree for embedded applications, I'd be surprised if there weren't 
a way we could have them act as a registry.

> For I2C specifically we already have both a dynamic way (kernel cmd  
> line) and static (i2c_board_info) to specify the i2c devices, why do  we 
> need yet another?

This uses i2c_board_info; it doesn't replace it.

-Scott
