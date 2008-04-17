Return-Path: <luoxu_gun@yahoo.com.cn>
Received: from web15901.mail.cnb.yahoo.com (web15901.mail.cnb.yahoo.com
	[202.165.103.82]) by ozlabs.org (Postfix) with SMTP id 0FA0EDE26B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 17:31:36 +1000 (EST)
Date: Thu, 17 Apr 2008 15:31:34 +0800 (CST)
From: =?gb2312?q?=D0=F1=20=C2=DE?= <luoxu_gun@yahoo.com.cn>
Subject: A question about the 8250/16550 Driver
To: Linu PPC Mail list <linuxppc-dev@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1887967415-1208417494=:9457"
Message-ID: <351993.9457.qm@web15901.mail.cnb.yahoo.com>
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-1887967415-1208417494=:9457
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello:
    I have founded that the serial can't be initialized as the bootting process. My platform is MPC8313 and my kernel version is linux-2.6.23.9. I look though the source code and find that the MPC8313 driver is compatible with 8250/16550. The driver is in the \drivers\serial\8250.c

In the function serial8250_isa_init_ports we should use the structer old_serial_port  but i can't find the definition for this struct. I can only find the following senrense in the head of this file 

#ifndef SERIAL_PORT_DFNS
#define SERIAL_PORT_DFNS
#endif

static const struct old_serial_port old_serial_port[] = {
    SERIAL_PORT_DFNS /* defined in asm/serial.h */
};

i think this is a bug for this driver. Could any one can told me how to define the SERIAL_PORT_DFNS  for the MPC8313 system? Hi Scott, Have you ever find this problem and how do you solve it.


Thanks
Best Wishs



       
---------------------------------
 —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°
--0-1887967415-1208417494=:9457
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

Hello:<br>&nbsp;&nbsp;&nbsp; I have founded that the serial can't be initialized as the bootting process. My platform is MPC8313 and my kernel version is linux-2.6.23.9. I look though the source code and find that the MPC8313 driver is compatible with 8250/16550. The driver is in the \drivers\serial\8250.c<br><br>In the function serial8250_isa_init_ports we should use the structer old_serial_port&nbsp; but i can't find the definition for this struct. I can only find the following senrense in the head of this file <br><br>#ifndef SERIAL_PORT_DFNS<br>#define SERIAL_PORT_DFNS<br>#endif<br><br>static const struct old_serial_port old_serial_port[] = {<br>&nbsp;&nbsp;&nbsp; SERIAL_PORT_DFNS /* defined in asm/serial.h */<br>};<br><br>i think this is a bug for this driver. Could any one can told me how to define the SERIAL_PORT_DFNS&nbsp; for the MPC8313 system? Hi Scott, Have you ever find this problem and how do you solve it.<br><br><br>Thanks<br>Best Wishs<br><br><br><p>&#32;


      <hr size=1><a href="http://cn.mail.yahoo.com/"> —≈ª¢” œ‰£¨ƒ˙µƒ÷’…˙” œ‰£°</a>
--0-1887967415-1208417494=:9457--
