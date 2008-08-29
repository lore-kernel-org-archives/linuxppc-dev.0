Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.227])
	by ozlabs.org (Postfix) with ESMTP id 130FBDDF6D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 19:40:18 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d11so1112958qbd.39
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 02:40:17 -0700 (PDT)
Message-ID: <319b0ac50808290240o973f96ckdc85a134646e1378@mail.gmail.com>
Date: Fri, 29 Aug 2008 11:40:17 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Advice : console
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16751_3738513.1220002817251"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_16751_3738513.1220002817251
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am trying to port linux for my ppc board. There is no keybord and no
scree. There is only UART.
I would like to have a console/terminal using UART.
What is the best way ? to write a serial driver using "struct  uart_driver"
or using "tty_driver" or to write a driver from scratch.
Maybe there is other way.

------=_Part_16751_3738513.1220002817251
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>
<br>
I am trying to port linux for my ppc board. There is no keybord and no scree. There is only UART.<br>
I would like to have a console/terminal using UART.<br>
What is the best way ? to write a serial driver using &quot;struct&nbsp;
uart_driver&quot; or using &quot;tty_driver&quot; or to write a driver from scratch.<br>
Maybe there is other way.<br>

------=_Part_16751_3738513.1220002817251--
