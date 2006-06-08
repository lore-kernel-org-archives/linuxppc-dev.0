Return-Path: <jianfei616@hotmail.com>
Message-ID: <BAY113-F12840A9A3ACBD5515A1350988B0@phx.gbl>
From: =?gb2312?B?ufkgvaO3xw==?= <jianfei616@hotmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: does Gianfar Ethernet Controller Version 1.1 support MARVELL 88E1111?
Date: Thu, 08 Jun 2006 15:43:20 +0800
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
I'm debugging my board with MPC 8540 and marvell 88e1111 designed on it. 
I'm sure the hardware connection is correct, and the phy's ID could be read 
through terminal port. But anyway, phy can not work. I wonder if it is the 
driver's problem? Since the Gianfar Ethernet Controller Version 1.1 
surpport 88e1011s, but some 88e1111's registers are different from 
88e1011s'. Actually I'm a new guy to Linux. Has anybody ever used 88e1111 
phy in Linux envirenmemt? Please  
give me some points. Thank you! 
I have read the Gianfar ethernet controller driver, but it's difficult for 
me to find out the sofware flow.
