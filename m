Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.173]) by ozlabs.org (Postfix) with ESMTP id 0D5842BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Dec 2004 00:22:31 +1100 (EST)
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Cci5V-0005x1-00
	for linuxppc-embedded@ozlabs.org; Fri, 10 Dec 2004 11:33:25 +0100
Received: from [217.228.214.86] (helo=[192.168.1.10])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1Cci5U-0004gx-00
	for linuxppc-embedded@ozlabs.org; Fri, 10 Dec 2004 11:33:25 +0100
Message-ID: <41B97BC7.3000200@anagramm.de>
Date: Fri, 10 Dec 2004 11:34:47 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20041210015932.A3B692BDA0@ozlabs.org>
	<200412100845.14486.g.jaeger@sysgo.com>
In-Reply-To: <200412100845.14486.g.jaeger@sysgo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello, Tony!

>>   I have successfully boot Linux 2.4.22 on my Lite5200 Evaluation Boar=
d with the ELDK. but when I want to use PCI slot for the video card,somet=
hing goes wrong. The whole board loses supply of electricity. And i take =
the video card out ,the board is still ok. So i change to put RTL81390 ne=
twork card into PCI slot. The same thing happen.
>>    The video card i have tried :
>>            S3 Trio64V
>>            Trident TGUI9680
>>            S3 ViRGE/DX

Don't use old (5V only) cards, the S3 drivers might be unmaintained for=20
your platform, too. If you want to integrate video into your final
system, you might want to check out some embedded solutions.

>>   Then I ask the Freescale support, they tell me that these board can =
operate in 5V slot only, While the PCI slot on Lite5200 only offers 3.3V.=
 These days though I search much information about vedio card. I still do=
n't which card can fit Lite5200.And I knew that the new CoralP PCI video =
card can support Lite5200. Can I get it from market? Anyway I really worr=
y about this, so I turn here and ask your help.and I really appreciate yo=
ur help! thanks a lot! (There was something wrong with my mailbox,I could=
 not receive the letters these days.So I post it again)=20
>>               Best Regards, =20
>>			   Tony Wang
>>=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=E3=80=80=
stcwang@163.net
>=20
>=20
> first of all, you need to take care of the PCI cards you use. As the Fr=
eescale support and=20
> also the manuals say: "Only 3.3V compliant PCI cards". In the meantime =
there are quite a lot
> of burned-out boards because of "wrong" cards.
> Next problem with the PCI bus on this board is, that because of some ti=
ming issues not all=20
> cards will be detected, so it'll be hard to find a video card, that mat=
ches these requirements.
> The only card that I know, which seems to work AND is somehow supported=
 is a CORAL-P evaluation=20
> board from Fujitsu. But this one is rather expensive.=20
> I tried also and old Nvidia Riva 128 card, which was detected correctly=
, but is not
> initialized correctly by the framebuffer driver.
 >
 > Regards,
 > Gerhard
 >

Yes, the Fujitsu Coral P should work also.
I use a Silicon Motion Inc. SM501 Voyager GX PCI Demo Board right now=20
which is supposed to work with all the embedded systems. You can get
that board for about EUR 495.- in Germany.
I am currently working on the framebuffer drivers for the Voyager on=20
PPC. Things seem to make good progress, here (there is an image on=20
screen :-). There is also an Epson or Asilient solution for embedded=20
systems, maybe you can check that also. YMMV

Best greets,

--=20
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
