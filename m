Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 6F3AB2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Dec 2004 19:26:05 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 10 Dec 2004 08:45:14 +0100
References: <20041210015932.A3B692BDA0@ozlabs.org>
In-Reply-To: <20041210015932.A3B692BDA0@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200412100845.14486.g.jaeger@sysgo.com>
Subject: Re: video card for Lite5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Friday 10 December 2004 02:33, wangwenbin wrote:
> Hi all
>=20
>    I have successfully boot Linux 2.4.22 on my Lite5200 Evaluation Board =
with the ELDK. but when I want to use PCI slot for the video card,something=
 goes wrong. The whole board loses supply of electricity. And i take the vi=
deo card out ,the board is still ok. So i change to put RTL81390 network ca=
rd into PCI slot. The same thing happen.
>     The video card i have tried :
>             S3 Trio64V
>             Trident TGUI9680
>             S3 ViRGE/DX
>    Then I ask the Freescale support, they tell me that these board can op=
erate in 5V slot only, While the PCI slot on Lite5200 only offers 3.3V. The=
se days though I search much information about vedio card. I still don't wh=
ich card can fit Lite5200.And I knew that the new CoralP PCI video card can=
 support Lite5200. Can I get it from market? Anyway I really worry about th=
is, so I turn here and ask your help.and I really appreciate your help! tha=
nks a lot! (There was something wrong with my mailbox,I could not receive t=
he letters these days.So I post it again)=20
>                Best Regards, =20
> 			   Tony Wang
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80s=
tcwang@163.net

first of all, you need to take care of the PCI cards you use. As the Freesc=
ale support and=20
also the manuals say: "Only 3.3V compliant PCI cards". In the meantime ther=
e are quite a lot
of burned-out boards because of "wrong" cards.
Next problem with the PCI bus on this board is, that because of some timing=
 issues not all=20
cards will be detected, so it'll be hard to find a video card, that matches=
 these requirements.
The only card that I know, which seems to work AND is somehow supported is =
a CORAL-P evaluation=20
board from Fujitsu. But this one is rather expensive.=20
I tried also and old Nvidia Riva 128 card, which was detected correctly, bu=
t is not
initialized correctly by the framebuffer driver.

Regards,
Gerhard

=2D-=20
Gerhard Jaeger <gjaeger@sysgo.com>           =20
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
