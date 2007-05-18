Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D019DDE07
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 03:35:34 +1000 (EST)
In-Reply-To: <464DDFA5.6050106@freescale.com>
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
	<464DDFA5.6050106@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <79CACFC8-DD5B-4284-AC2E-C92FE2A85330@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Fri, 18 May 2007 12:33:48 -0500
To: Scott Wood <scottwood@freescale.com>
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


On May 18, 2007, at 12:17 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> On May 18, 2007, at 11:35 AM, Scott Wood wrote:
>>> Kumar Gala wrote:
>>>
>>>> I guess my gripe is about proposing a solution and not willing  
>>>> to   extend it in light of people providing issues with it.
>>>
>>>
>>> I'm perfectly willing to extend it if you let me know what you   
>>> think is needed, rather than just saying "switches and muxes".    
>>> What *specifically* would they need beyond what I proposed?
>> I provided you an example device and asked you to explain how it   
>> would be described in what you are proposing.
>
> And I did.  What did you find lacking in the device tree fragment I  
> suggested?

Once you expand the beyond just a root node for the controller I'd  
like to see how you suggest we handle the case where a particular  
child ends up having children as well.  You example, is sufficient  
the majority of devices, but I'd like to know that we'll be able to  
handle the case where a node is both a device and controller.

>> I never said don't bother because you didn't cover the switch/mux   
>> case.  I said don't bother because I don't see what the value is   
>> creating a namespace that no one is going to manage and thus will  
>> end  up most likely being linux specific, and linux already  
>> provides a  solution for the problem.
>
> Given that power.org is attempting to do further standardization of  
> the device tree for embedded applications, I'd be surprised if  
> there weren't a way we could have them act as a registry.

If/when they sign up for this I'd be more inclined to have kernel  
support for it.

>> For I2C specifically we already have both a dynamic way (kernel  
>> cmd  line) and static (i2c_board_info) to specify the i2c devices,  
>> why do  we need yet another?
>
> This uses i2c_board_info; it doesn't replace it.

Ok, but what functionality does it give us that we dont already have  
today?

- k
