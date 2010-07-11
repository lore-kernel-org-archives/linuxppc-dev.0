Return-Path: <jodorowsky.a@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 376C4B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 11 Jul 2010 23:26:43 +1000 (EST)
Received: by wwb13 with SMTP id 13so1801079wwb.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 11 Jul 2010 06:26:40 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 11 Jul 2010 15:26:39 +0200
Message-ID: <AANLkTil0oDHNQ2RwmK0eerf5c5Y1Rffkc-TtaGTrJVpt@mail.gmail.com>
Subject: C67x00 USB Host
From: A C <jodorowsky.a@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016364ef99a11ce26048b1c9653
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364ef99a11ce26048b1c9653
Content-Type: text/plain; charset=ISO-8859-1

Hello,
I am currently trying to use the C67x00 driver in the vanilla branch of
Linux. I use it in coprocessor hpi mode (GPIO30 and GPIO31 =0) There is
something that I do not understand in the code.
In the probe() function there is a call to the function hpi_reg_init(). In
this function the interrupts are no more routed from HPI.
Then, in the probe function, the ll_reset() is called, there is a send in
the mailbox, and the response should be an interupt. But I do not receveive
any interrupt. I think it is normal because as I said they are no more
routed from the HPI. So I think I miss something.
Someone could tell me where the interrupt are routed towards HPI ?
Thanks by advance
Adrien

--0016364ef99a11ce26048b1c9653
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br>I am currently trying to use the C67x00 driver in the vanilla bra=
nch of Linux. I use it in coprocessor hpi mode (GPIO30 and GPIO31 =3D0) The=
re is something that I do not understand in the code.<br>In the probe() fun=
ction there is a call to the function hpi_reg_init(). In this function the =
interrupts are no more routed from HPI. <br>
Then, in the probe function, the ll_reset() is called, there is a send in t=
he mailbox, and the response should be an interupt. But I do not receveive =
any interrupt. I think it is normal because as I said they are no more rout=
ed from the HPI. So I think I miss something.<br>
Someone could tell me where the interrupt are routed towards HPI ?<br>Thank=
s by advance<br>Adrien<br><pre><br></pre><br>

--0016364ef99a11ce26048b1c9653--
