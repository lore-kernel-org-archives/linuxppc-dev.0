Return-Path: <bastiaan.nijkamp@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 340371007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Nov 2010 04:03:55 +1100 (EST)
Received: by yxs7 with SMTP id 7so2640095yxs.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Nov 2010 10:03:52 -0700 (PDT)
MIME-Version: 1.0
From: Bastiaan Nijkamp <bastiaan.nijkamp@gmail.com>
Date: Fri, 5 Nov 2010 18:03:31 +0100
Message-ID: <AANLkTi=UcS-5tvJbw4yfY_JC1mHRHMJZS1tLCt75bE3L@mail.gmail.com>
Subject: RapidIO: Flowcontrol?
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=20cf304353e24f272204945142c1
Cc: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>,
	John Traill <JTRAILL@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf304353e24f272204945142c1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am currently working on a character device to benchmark the difference in
performance between an ethernet driver (rionet) and a character driver. One
issue that i am currently having is that i sometimes run out of mailbox
buffers when there is a lot of data being received. The read function then
does not get a chance to read the data because it
is continuously interrupted by the inbound ISR. When the receiver runs out
of buffers i would have expected that the transmitter would receive an
retry-packet symbol and that the data arrives as soon as some of the buffers
are cleared and reallocated (receiver controlled flow-control). Instead, the
transceiver totally hangs and i have to reset the processor to solve this. I
am using a p2p connection with two sbc85487 boards from windriver that both
feature a PowerQuicc 8548E.

Do i have to take actions when i reallocate the buffers e.g. resetting the
Mailbox Full error bit back to zero or something else?

Regards,
Bastiaan Nijkamp

--20cf304353e24f272204945142c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I am currently working on a character device to benc=
hmark the difference in performance between an ethernet driver (rionet) and=
 a character driver. One issue that i am currently having is that i sometim=
es run out of mailbox buffers when there is a lot of data being received. T=
he read function then does not get a chance to read the data because it is=
=A0continuously=A0interrupted by the inbound ISR. When the receiver runs ou=
t of buffers i would have expected that the transmitter would receive an re=
try-packet symbol and that the data arrives as soon as some of the buffers =
are cleared and reallocated (receiver controlled flow-control). Instead, th=
e transceiver totally hangs and i have to reset the processor to solve this=
. I am using a p2p connection with two sbc85487 boards from windriver that =
both feature a PowerQuicc 8548E.</div>

<div><br></div><div>Do i have to take actions when i reallocate the buffers=
 e.g. resetting the Mailbox Full error bit back to zero or something else?=
=A0</div><div><br></div><div>Regards,</div><div>Bastiaan Nijkamp</div><div>

<br></div><div><br></div><div><br></div>

--20cf304353e24f272204945142c1--
