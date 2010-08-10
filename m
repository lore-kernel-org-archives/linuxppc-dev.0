Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id 8C019B6EFE
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 22:59:07 +1000 (EST)
Received: by pzk30 with SMTP id 30so6304106pzk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 05:59:06 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Aug 2010 18:29:05 +0530
Message-ID: <AANLkTinxyoUkDdZyBn742YHMPHQPhUZ+g9D5ALrnVT6i@mail.gmail.com>
Subject: Accessing GPIO registers on MPC8377ERDB board
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=00163646c7c0b862f2048d77b220
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163646c7c0b862f2048d77b220
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I want to access the GPIO registers present in MPC8377ERDB board. I have to
write a GPIO driver for that, I am completely confused that how to do it.
Please suggest some way or doc to start with.

For the start-up, I was thinking of setting GPIO pins 9, 10 and 11 present
on the board to active low as they are connected to leds D3, D4 and D5 resp.


Thanks in advance
Ravi Gupta

--00163646c7c0b862f2048d77b220
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I want to access the GPIO registers present in MPC8377ERDB board=
. I have to write a GPIO driver for that, I am completely confused that how=
 to do it. Please suggest some way or doc to start with. <br><br>For the st=
art-up, I was thinking of setting GPIO pins 9, 10 and 11 present on the boa=
rd to active low as they are connected to leds D3, D4 and D5 resp. <br>
<br>Thanks in advance<br>Ravi Gupta<br>

--00163646c7c0b862f2048d77b220--
