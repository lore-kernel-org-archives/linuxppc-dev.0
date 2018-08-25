Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41yTyJ3lc8zDqwt
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 06:19:17 +1000 (AEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Date: Sat, 25 Aug 2018 22:19:07 +0200
Subject: Re: FSL/NXP P5020: USB problems with the latest Git kernels
Message-Id: <76A7B415-F6D4-4BF8-B4B7-B146C5337CF8@xenosoft.de>
References: <0F797F4E-755B-499C-BA74-48CC03235393@xenosoft.de>
In-Reply-To: <0F797F4E-755B-499C-BA74-48CC03235393@xenosoft.de>
To: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

With the boot argument =E2=80=9Cmem=3D3500M=E2=80=9D the USB devices work. P=
lease compile the latest Git kernel and test it on your P5020 board. There i=
s a problem with the memory management since 22/08/18. I can=E2=80=99t test b=
ecause I don=E2=80=99t have a P5020 board here and our users can=E2=80=99t c=
ompile kernels.

Thanks,
Christian

Sent from my iPhone

> On 24. Aug 2018, at 20:11, Christian Zigotzky <chzigotzky@xenosoft.de> wro=
te:
>=20
> Hello,
>=20
> There are USB problems with P5020 boards with the latest Git kernels.
>=20
> Some users reported the following error messages:
>=20
> skateman@X5000LNX:~$ grep -i -E 'usb.*error' /var/log/syslog
> Aug 24 13:12:50 X5000LNX kernel: [ 6.552303] usb 1-1: device descriptor re=
ad/64, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 6.649376] usb 2-1: device descriptor re=
ad/64, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 6.794158] usb 1-1: device descriptor re=
ad/64, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 6.883156] usb 2-1: device descriptor re=
ad/64, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 7.139155] usb 1-1: device descriptor re=
ad/64, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 7.226156] usb 2-1: device descriptor re=
ad/64, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 7.363155] usb 1-1: device descriptor re=
ad/64, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 7.451156] usb 2-1: device descriptor re=
ad/64, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 8.521156] usb 1-1: device not accepting=
 address 4, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 8.609156] usb 2-1: device not accepting=
 address 4, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 9.057155] usb 1-1: device not accepting=
 address 5, error -32
> Aug 24 13:12:50 X5000LNX kernel: [ 9.145157] usb 2-1: device not accepting=
 address 5, error -32
>=20
> I don=E2=80=99t have a P5020 board here. That means I can=E2=80=99t bisect=
 and test. Therefore I need your help. The problematic Git commit must be so=
mewhere between 22/08/18 1:20 PM UTC and 23/08/18 10:49 AM UTC.
> The Git kernel from 22/08/18 1:20 PM UTC works with USB devices.
> Could you please compile a Git kernel and test it on your P5020 board?
>=20
> Thanks,
> Christian
