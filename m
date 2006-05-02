Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15AE267B86
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 08:35:56 +1000 (EST)
In-Reply-To: <20060502220242.2001.qmail@web37812.mail.mud.yahoo.com>
References: <20060502220242.2001.qmail@web37812.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C7A2986C-E416-4B0D-A3D8-F974B4B8D96C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: cfg_lock
Date: Tue, 2 May 2006 17:35:44 -0500
To: Eric Heim <sheldoninstruments@yahoo.com>
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


On May 2, 2006, at 5:02 PM, Eric Heim wrote:

> Anybody know how the cfg_lock bit is manipulated on the MPC8349EMDS  
> board?  I know the bit is in the internal configuration registers  
> but how is this bit flipped on boot?  We are trying to boot the  
> board as an agent in a PC.  We can only do this using the hard  
> coded option.  We would like to boot the board with the reset  
> config word in the I2C but we can't boot the board with the 'core  
> disabled' as we would like(it only works if the core enable bit is  
> set, otherwise the PC hangs and won't boot).  We are hoping to use  
> a pre-load command in the boot sequencer,  but there is little  
> information on how this can be done or if it can be done.  We can  
> flip the bit from u-boot or using our driver when the PC has booted  
> up but we need some way to flip the bit during boot to allow our PC  
> to get its proper configuration cycles.  Any ideas?

You have the right idea about using the I2C to handle various  
register and config writes.  However, the UM details how to setup  
your EEPROM so that I2C boot sequencer can process it.

See section 4.4.3 in the UM.

- k
