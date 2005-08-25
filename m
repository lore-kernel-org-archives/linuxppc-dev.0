Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 0A4EA6812C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 17:38:19 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so354110wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 00:38:17 -0700 (PDT)
Message-ID: <9b7ca657050825003843373dd9@mail.gmail.com>
Date: Thu, 25 Aug 2005 16:38:17 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: I2C STOP condition on MPC8245
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks,

Just wondering, if anyone tried i2c multi-master using mpc8245 with
kernel 2.6.x.
Thing is, version of kernel doesnt really matter, since I only have
problem getting mpc8245 to detect STOP condition sent by the
atmega64(the other i2c device).

Not knowing I2C that much, Im curious to know if mpc8245 should raise
an interrupt if it detects STOP condition sent by the master device.

I have no problem with i2c communication if mpc8245 is master, but
only when mpc8245 acts as slave, I cant detect the end of transfer.

If mpc8245 doesnt raise an interrupt when it detect STOP condition,
then how should program running on mpc8245 to know when to stop
reading ?

--=20
Daniel
