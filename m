Return-Path: <ryan@elevated-networks.com>
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <84A6F2F4-25E7-11D9-BA35-0050E4B0DC64@elevated-networks.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-embedded@ozlabs.com
From: Ryan Wilkins <ryan@elevated-networks.com>
Date: Sun, 24 Oct 2004 14:07:07 -0400
Cc: 
Subject: MPC850 and GDB help
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello..  I'm very new to embedded systems but want to learn a bit more 
by using existing hardware.  In this case, the existing hardware is a 
DirectvDSL ADSL modem based on the MPC850 processor.  I've located the 
BDM port and built a MPCBDM version 2 interface to communicate with the 
MPC850.  The interface works just fine.

What I want to do now is to load the u-boot bootloader onto the board.  
What I'm trying to accomplish now is to load the u-boot code into ram 
and run it.  I don't have my flash definitions right in MPCBDM yet, 
otherwise I'd try to flash it.  I realize that this is not going to be 
an easy task, but what better way to learn than to dive right in.  So.. 
  I'm stumped.  Can anyone provide just a little bit of idea of where to 
go from here?  Perhaps a tutorial URL, or some past experience in 
working with the 850?

The board has a single 4 Mbyte flash chip (Intel DA28F320J5) and 16 
Mbyte RAM.

Thanks,
Ryan Wilkins
