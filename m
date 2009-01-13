Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBF92DE0F1
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 08:17:41 +1100 (EST)
Message-Id: <EB245BEE-52C5-40DD-A9DD-A106A5937219@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1231880384.22571.46.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Please pull from 'next' branch (2.6.29)
Date: Tue, 13 Jan 2009 15:17:36 -0600
References: <Pine.LNX.4.64.0901130917190.21289@blarg.am.freescale.net>
	<1231880384.22571.46.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 13, 2009, at 2:59 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2009-01-13 at 09:21 -0600, Kumar Gala wrote:
>> Please pull from 'next' branch of
>>
>> (this is my last pull request of 'next' for 2.6.29.  I would like  
>> to see
>> the 'powerpc: Unify opcode definitions and support' patch go in but  
>> leave
>> that for you to pull in directly).
>
> This is really very very very late for these changes, most of them
> aren't bug fixes at all...

True.

>> Anton Vorontsov (4):
>>      powerpc/fsl_pci: Add MPC83xx PCI-E controller RC mode support
>>      powerpc/83xx: Add PCI-E support for all MPC83xx boards with  
>> PCI-E

Would like to see this feature added into .29

>>      powerpc/83xx: Make serial ports work on MPC8315E-RDB w/ FSL U- 
>> Boots

A sort of bug fix.

>>      powerpc/83xx: Move mcu_mpc8349emitx driver out of drivers/i2c/ 
>> chips/

At Jean's request to move i2c clients out of drivers/i2c.

>> Kumar Gala (2):
>>      powerpc/fsl-booke: Cleanup init/exception setup to be runtime
>>      powerpc/e500mc: Doorbells need to be taken w/exceptions disabled

can wait for .30

>> Trent Piepho (3):
>>      powerpc/fsl-booke: Remove code duplication in lowmem mapping
>>      powerpc/fsl-booke: Allow larger CAM sizes than 256 MB
>>      powerpc/fsl-booke: Make CAM entries used for lowmem configurable

Posted we'll before.. finally got around to reviewing them.. but can  
wait for .30

So the real question I have is when does your next branch start  
queuing up changes for .30?

I can completely live w/these not going into .29 if they can go into  
your next branch for .30

- k
