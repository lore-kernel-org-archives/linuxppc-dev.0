Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zg6t2g4FzDrS7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 04:15:47 +1000 (AEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Date: Mon, 27 Aug 2018 20:15:39 +0200
Subject: FSL/NXP P5020: USB problems with the latest Git kernels
Message-Id: <196C6151-3085-4A42-B6D6-5891F4AF9759@xenosoft.de>
References: <0F797F4E-755B-499C-BA74-48CC03235393@xenosoft.de>
 <76A7B415-F6D4-4BF8-B4B7-B146C5337CF8@xenosoft.de>
In-Reply-To: <76A7B415-F6D4-4BF8-B4B7-B146C5337CF8@xenosoft.de>
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

Our users tested the RC1 of kernel 4.19 on their P5020 boards today. Unfortu=
nately the USB bug still exists. With mem values bigger than 4096M, the USB m=
ouse and keyboard doesn=E2=80=99t work. With the bootarg mem=3D4096M, the US=
B devices work without any problems. Please compile the RC1 and test it on y=
our P5020 board. There is a problem with the memory management since 22/08/1=
8.=20

Thanks,
Christian

Sent from my iPhone

> On 25. Aug 2018, at 22:19, Christian Zigotzky <chzigotzky@xenosoft.de> wro=
te:
>=20
> Hello,
>=20
> With the boot argument =E2=80=9Cmem=3D3500M=E2=80=9D the USB devices work.=
 Please compile the latest Git kernel and test it on your P5020 board. There=
 is a problem with the memory management since 22/08/18. I can=E2=80=99t tes=
t because I don=E2=80=99t have a P5020 board here and our users can=E2=80=99=
t compile kernels.
>=20
> Thanks,
> Christian
>=20
> Sent from my iPhone
>=20
>> On 24. Aug 2018, at 20:11, Christian Zigotzky <chzigotzky@xenosoft.de> wr=
ote:
>>=20
>> Hello,
>>=20
>> There are USB problems with P5020 boards with the latest Git kernels.
>>=20
>> Some users reported the following error messages:
>>=20
>> skateman@X5000LNX:~$ grep -i -E 'usb.*error' /var/log/syslog
>> Aug 24 13:12:50 X5000LNX kernel: [ 6.552303] usb 1-1: device descriptor r=
ead/64, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 6.649376] usb 2-1: device descriptor r=
ead/64, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 6.794158] usb 1-1: device descriptor r=
ead/64, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 6.883156] usb 2-1: device descriptor r=
ead/64, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 7.139155] usb 1-1: device descriptor r=
ead/64, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 7.226156] usb 2-1: device descriptor r=
ead/64, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 7.363155] usb 1-1: device descriptor r=
ead/64, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 7.451156] usb 2-1: device descriptor r=
ead/64, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 8.521156] usb 1-1: device not acceptin=
g address 4, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 8.609156] usb 2-1: device not acceptin=
g address 4, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 9.057155] usb 1-1: device not acceptin=
g address 5, error -32
>> Aug 24 13:12:50 X5000LNX kernel: [ 9.145157] usb 2-1: device not acceptin=
g address 5, error -32
>>=20
>> I don=E2=80=99t have a P5020 board here. That means I can=E2=80=99t bisec=
t and test. Therefore I need your help. The problematic Git commit must be s=
omewhere between 22/08/18 1:20 PM UTC and 23/08/18 10:49 AM UTC.
>> The Git kernel from 22/08/18 1:20 PM UTC works with USB devices.
>> Could you please compile a Git kernel and test it on your P5020 board?
>>=20
>> Thanks,
>> Christian
