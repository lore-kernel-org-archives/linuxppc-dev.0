Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 0420267E8E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Aug 2005 15:16:26 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so315574wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 22:16:25 -0700 (PDT)
Message-ID: <9b7ca6570508102216298a6585@mail.gmail.com>
Date: Thu, 11 Aug 2005 14:16:25 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: I2C (slave mode) with MPC8245
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

I've been toddling with the i2c codes at the moment, and it seems that
if I make 8245 as master, it communicates perfectly well with my other
device.
However, getting 8245 to act as slave is proving to be a challenge.

I'm currently working with kernel 2.6.12.3 and finding pieces of code
that should deal with slave mode transfer is missing from i2c-mpc.c.
Is there any place I could get it ? or if I have to do it, may be an
advice or suggestion would be appreciated.

Thanks.

--=20
Daniel
