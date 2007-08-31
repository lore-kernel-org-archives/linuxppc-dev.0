Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id E7851DDE03
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 12:37:09 +1000 (EST)
Message-ID: <388526407.00819@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 31 Aug 2007 10:13:27 +0800
Subject: The question about the relocate_code on u-boot for MPC8360?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi, Friends,


I am debuging the u-boot on freescale MPC8360, the version of u-boot is 1.2.0, the
code on flash is OK,but the code from FLASH to DDR is broken, that is, after the
relocate_code function, the u-boot start again. I tested the DDR on u-boot, it's
OK. I was wondering that hot to deal with this problem? follow is the COM output
from u-boot. Thanks.







U-Boot 1.2.0 (Aug 29 2007 - 20:50:37) MPC83XX

Clock configuration:
  Coherent System Bus:  264 MHz
  Core:                 528 MHz
  QE:                   198 MHz
  Local Bus Controller: 264 MHz
  Local Bus:             66 MHz
  DDR:                  264 MHz
  DDR Secondary:        264 MHz
  SEC:                   88 MHz
  I2C1:                 264 MHz
  I2C2:                 264 MHz
CPU: Rev: Unknown guojing modified source code
Rev: 20 at 528 MHz
Board: Freescale MPC8360EMDS
I2C:   ready
DRAM:
   SDRAM on Local Bus: 64 MB
   DDR RAM: 256 MB
DDR test phase 1:
DDR test phase 2:
DDR test passed.
init_sequence finished
begin set up a new stack
beginning memcpy
ended memcpy,beginning relocate_code


U-Boot 1.2.0 (Aug 29 2007 - 20:50:37) MPC83XX

Clock configuration:
  Coherent System Bus:  264 MHz
  Core:                 528 MHz
  QE:                   198 MHz
  Local Bus Controller: 264 MHz
  Local Bus:             66 MHz
  DDR:                  264 MHz
  DDR Secondary:        264 MHz
  SEC:                   88 MHz
  I2C1:                 264 MHz
  I2C2:                 264 MHz
CPU: Rev: Unknown guojing modified source code
Rev: 20 at 528 MHz
Board: Freescale MPC8360EMDS
I2C:   ready
DRAM:
   SDRAM on Local Bus: 64 MB
   DDR RAM: 256 MB
DDR test phase 1:
DDR test phase 2:
DDR test passed.
init_sequence finished
begin set up a new stack
beginning memcpy
ended memcpy,beginning relocate_code
