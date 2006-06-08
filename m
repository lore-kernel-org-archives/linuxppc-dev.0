Return-Path: <DaveLiu@freescale.com>
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD943@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: =?gb2312?B?J7n5IL2jt8cn?= <jianfei616@hotmail.com>,
	Linuxppc-embedded@ozlabs.org
Subject: RE: does Gianfar Ethernet Controller Version 1.1 support MARVELL
	88E1111?
Date: Thu, 8 Jun 2006 16:41:30 +0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hi all,
> I'm debugging my board with MPC 8540 and marvell 88e1111 
> designed on it. 
> I'm sure the hardware connection is correct, and the phy's ID 
> could be read 
> through terminal port. But anyway, phy can not work. I wonder 

Are you sure the hardware is no problem?
Can you successfully tftp files with the port in u-boot?
What is the phy interface mode you used? 

> if it is the 
> driver's problem? Since the Gianfar Ethernet Controller Version 1.1 
> surpport 88e1011s, but some 88e1111's registers are different from 
> 88e1011s'. Actually I'm a new guy to Linux. Has anybody ever 
> used 88e1111 
> phy in Linux envirenmemt? Please  

Basically, the 88e1111 is same 88e1011s.

> give me some points. Thank you! 
> I have read the Gianfar ethernet controller driver, but it's 
> difficult for 
> me to find out the sofware flow.
> 
Change the board-specific things, for example
PHY address, PHY interrupt. 
Please reference /arch/ppc/platforms/85xx/mpc8540_ads.c

-Dave
