Return-Path: <tath76@yahoo.com>
Message-ID: <20050303101910.74163.qmail@web51406.mail.yahoo.com>
Date: Thu, 3 Mar 2005 02:19:10 -0800 (PST)
From: T T <tath76@yahoo.com>
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2015323129-1109845150=:73576"
Subject: port linux to xc2vp4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2015323129-1109845150=:73576
Content-Type: text/plain; charset=us-ascii

Hi all,
 
Can any show me step by step to port linux kernel to the custom board.  this board has xc2vp4 (xilinx fpga) that contains a powerpc 405, and I have used EDK software from Xilinx to add spi controller, uartlite, and sdram controller, no ethernet on this board.  Do I need to build the toolchain for powerpc; if it need the toolchains, then where to get it.  Beside I don't know how to configure the linux kernel (for example I download linux-2.4.18.tar.gz) then do "make menuconfigure" some of selection like "MTD" I don't know if I need to select it as a yet or not because on my custom board I have serial flash from ST M32P80.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2015323129-1109845150=:73576
Content-Type: text/html; charset=us-ascii

<DIV>Hi all,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Can any show me step by step to port linux kernel to the custom board.&nbsp; this board has xc2vp4 (xilinx fpga) that contains a powerpc 405, and I have used EDK software from Xilinx to add spi controller, uartlite, and sdram controller, no ethernet on this board.&nbsp; Do I need to build the toolchain for powerpc; if it need the toolchains, then where to get it.&nbsp; Beside I don't know how to configure the linux kernel (for example I download linux-2.4.18.tar.gz) then do "make menuconfigure"&nbsp;some of selection like "MTD" I don't know if I need to select it as a yet or not because on my custom board I have serial flash from ST M32P80.</DIV><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-2015323129-1109845150=:73576--
