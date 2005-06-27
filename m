Return-Path: <susheel_nuguru@yahoo.co.in>
Received: from web8504.mail.in.yahoo.com (web8504.mail.in.yahoo.com
	[202.43.219.166]) by ozlabs.org (Postfix) with SMTP id 4CCB667A45
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Jun 2005 19:09:24 +1000 (EST)
Message-ID: <20050627090243.98833.qmail@web8504.mail.in.yahoo.com>
Date: Mon, 27 Jun 2005 02:02:43 -0700 (PDT)
From: Susheel Raj <susheel_nuguru@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: U_BOOT console baudrate mismatch
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
 
 I am a newbie in this area and i am here hoping some
help from our friendly programmers. I am working with
PwerPc processor MPC5200 with the board that was
produced in our company. Rightnow we have U_BOOT-1.1.1
and the problem is that it doesnt print wel on the
console. I have no hands on experience in workin with
u-boot... 

the messages look very ugly like this ....


U-Boot 1.1.1 (Ju&#65533;23 2005 - 11:29:29)

CPU:   MPC5200 (JTAG ID 0001101d) at 396 .Hz
       .us 132 MH IPB 66 MHz, PCI 33 .Hz
Boardo Mitron .CT3
.F..SH:  4 M.
.In:    ser&#65533;ld FPGA binary image
Out:   serial
Err:   serial
NAND:      

---------------
Bus --> 132MH 
IPB ---> 66 MH 
PCI ---> 33 MH 
FLASH --> 4M
and so on..

 my server machine to which the board is connected has
the console with baud 38400 and i think u-boot default
baudrate is 115200 or 19200 (i am not sure)... where
should i need to change???? any sort of help or
redirections is greatly appreciated...

thanks a lot for you replies in advance


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com
