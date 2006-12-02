Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0506.google.com [64.233.162.232])
	by ozlabs.org (Postfix) with ESMTP id 092F067B99
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 14:03:25 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id l1so1746176nzf
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Dec 2006 19:03:23 -0800 (PST)
Message-ID: <198592450612011903r3e9311e5ke3f5e7b305108fe7@mail.gmail.com>
Date: Sat, 2 Dec 2006 03:03:23 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: MPC83xx SPI controller questions
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8867_28289846.1165028603642"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_8867_28289846.1165028603642
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings!

I'm trying to make mmc/sd card whihc is connect to MPC8343E SPI controller
to work. I found there are SPI drivers added after kernel 2.6.16, but we're
using kernel 2.6.14. I have a few questions help someone could help out.

- Has anyone backward ported SPI driver to kernel 2.6.14?
- Does spi_mpc83xx.c work for MPC8343E cpu? I saw some comments of Kumar
Gala to say the driver is not for CPM or Quiccengine SPI controller, but I
think 8343 is one of quiccengine
- I don't see any arch/ppc change for SPI like done for TSEC, e.g., we need
to declar the platform device, and init platform data. Is this correct? how
to test this driver? Or say, how to make this driver work? I only saw
/sys/bus/platform/drivers/mpc83xx_spi/ created but no sure if SPI controller
works.

Thanks in advance.

- Reeve

------=_Part_8867_28289846.1165028603642
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings!<br>
<br>
I'm trying to make mmc/sd card whihc is connect to MPC8343E SPI
controller to work. I found there are SPI drivers added after kernel
2.6.16, but we're using kernel 2.6.14. I have a few questions help
someone could help out.<br>
<br>
- Has anyone backward ported SPI driver to kernel 2.6.14?<br>
- Does spi_mpc83xx.c work for MPC8343E cpu? I saw some comments of
Kumar Gala to say the driver is not for CPM or Quiccengine SPI
controller, but I think 8343 is one of quiccengine<br>
- I don't see any arch/ppc change for SPI like done for TSEC, e.g., we
need to declar the platform device, and init platform data. Is this
correct? how to test this driver? Or say, how to make this driver work?
I only saw /sys/bus/platform/drivers/mpc83xx_spi/ created but no sure
if SPI controller works.<br>
<br>
Thanks in advance.<br>
<br>
- Reeve<br>

------=_Part_8867_28289846.1165028603642--
