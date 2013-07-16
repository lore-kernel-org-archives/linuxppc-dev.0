Return-Path: <neorf3k@gmail.com>
Received: from mail-ee0-x235.google.com (mail-ee0-x235.google.com
 [IPv6:2a00:1450:4013:c00::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F4302C0130
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 10:08:32 +1000 (EST)
Received: by mail-ee0-f53.google.com with SMTP id c41so22969eek.26
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 17:08:28 -0700 (PDT)
Subject: Help on mpc5200b and 1:1 CPU:bus clock ratio
Mime-Version: 1.0 (1.0)
From: Neorf3k <neorf3k@gmail.com>
Content-Type: multipart/alternative;
 boundary=Apple-Mail-A34C375F-A7F1-471B-8EF2-DB45D0448E7C
Message-Id: <0897B824-1A4F-412B-9FA1-D26DF191CFD5@gmail.com>
Date: Tue, 16 Jul 2013 02:08:26 +0200
To: Linux Ppc Dev List <linuxppc-dev@lists.ozlabs.org>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-A34C375F-A7F1-471B-8EF2-DB45D0448E7C
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hello, this is our custom board's u-boot:

U-Boot 2009.08 (Apr 19 2010 - 05:35:19)                              =20

CPU:   MPC5200B v2.2, Core v1.4 at 132 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 66 MHz
Board: Ran Controller Board
I2C:   85 kHz, ready
DRAM:  128 MB
FLASH: 64 MB

We have 1:1 CPU:bus clock ratio and for now we are having problems with Fec d=
rivers (I suppose).=20
Using 2.6.33 kernel, during a ping session, we have 60% packet loss.
We can't change kernel.

Where could I find the problem in the kernel?=20

Thank you so much

Lorenzo=20=

--Apple-Mail-A34C375F-A7F1-471B-8EF2-DB45D0448E7C
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div>Hello, this is our custom board's u-bo=
ot:</div><div><br></div><div><div style=3D"font-family: '.Helvetica NeueUI';=
 font-size: 18px; line-height: 24px; -webkit-tap-highlight-color: rgba(26, 2=
6, 26, 0.296875); -webkit-composition-fill-color: rgba(130, 98, 83, 0.097656=
3); -webkit-composition-frame-color: rgba(191, 107, 82, 0.496094); -webkit-t=
ext-size-adjust: none; ">U-Boot 2009.08 (Apr 19 2010 - 05:35:19) &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;&nbsp;</div><div style=3D"font-family: '.Helvetica NeueUI';=
 font-size: 18px; line-height: 24px; -webkit-tap-highlight-color: rgba(26, 2=
6, 26, 0.296875); -webkit-composition-fill-color: rgba(130, 98, 83, 0.097656=
3); -webkit-composition-frame-color: rgba(191, 107, 82, 0.496094); -webkit-t=
ext-size-adjust: none; "><br></div><div style=3D"font-family: '.Helvetica Ne=
ueUI'; font-size: 18px; line-height: 24px; -webkit-tap-highlight-color: rgba=
(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba(130, 98, 83, 0.=
0976563); -webkit-composition-frame-color: rgba(191, 107, 82, 0.496094); -we=
bkit-text-size-adjust: none; ">CPU: &nbsp; MPC5200B v2.2, Core v1.4 at 132 M=
Hz</div><div style=3D"font-family: '.Helvetica NeueUI'; font-size: 18px; lin=
e-height: 24px; -webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -we=
bkit-composition-fill-color: rgba(130, 98, 83, 0.0976563); -webkit-compositi=
on-frame-color: rgba(191, 107, 82, 0.496094); -webkit-text-size-adjust: none=
; ">&nbsp; &nbsp; &nbsp; &nbsp;Bus 132 MHz, IPB 132 MHz, PCI 66 MHz</div><di=
v style=3D"font-family: '.Helvetica NeueUI'; font-size: 18px; line-height: 2=
4px; -webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-compos=
ition-fill-color: rgba(130, 98, 83, 0.0976563); -webkit-composition-frame-co=
lor: rgba(191, 107, 82, 0.496094); -webkit-text-size-adjust: none; ">Board: R=
an Controller Board</div><div style=3D"font-family: '.Helvetica NeueUI'; fon=
t-size: 18px; line-height: 24px; -webkit-tap-highlight-color: rgba(26, 26, 2=
6, 0.296875); -webkit-composition-fill-color: rgba(130, 98, 83, 0.0976563); -=
webkit-composition-frame-color: rgba(191, 107, 82, 0.496094); -webkit-text-s=
ize-adjust: none; ">I2C: &nbsp; 85 kHz, ready</div><div style=3D"font-family=
: '.Helvetica NeueUI'; font-size: 18px; line-height: 24px; -webkit-tap-highl=
ight-color: rgba(26, 26, 26, 0.296875); -webkit-composition-fill-color: rgba=
(130, 98, 83, 0.0976563); -webkit-composition-frame-color: rgba(191, 107, 82=
, 0.496094); -webkit-text-size-adjust: none; ">DRAM: &nbsp;128 MB</div><div s=
tyle=3D"font-family: '.Helvetica NeueUI'; font-size: 18px; line-height: 24px=
; -webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); -webkit-compositi=
on-fill-color: rgba(130, 98, 83, 0.0976563); -webkit-composition-frame-color=
: rgba(191, 107, 82, 0.496094); -webkit-text-size-adjust: none; ">FLASH: 64 M=
B</div><div><br></div><div>We have 1:1 CPU:bus clock ratio and for now we ar=
e having problems with Fec drivers (I suppose).&nbsp;</div><div>Using 2.6.33=
 kernel, during a ping session, we have 60% packet loss.</div><div>We can't c=
hange kernel.</div><div><br></div><div>Where could I find the problem in the=
 kernel?&nbsp;</div><div><br></div><div>Thank you so much</div><div><br></di=
v><div>Lorenzo&nbsp;</div></div></body></html>=

--Apple-Mail-A34C375F-A7F1-471B-8EF2-DB45D0448E7C--
