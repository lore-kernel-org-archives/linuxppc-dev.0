Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f218.google.com (mail-ew0-f218.google.com
	[209.85.219.218]) by ozlabs.org (Postfix) with ESMTP id 5F98AB7CD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jan 2010 02:35:04 +1100 (EST)
Received: by ewy10 with SMTP id 10so97045ewy.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jan 2010 07:35:01 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: =?utf-8?B?5pmv5paH5p6X?= <wenlinjing@gmail.com>
Subject: Re: How to trun off udbg0 during bootup?
References: <b90a809a1001201702y7d42eb60v43f24cb1043a89fa@mail.gmail.com>
Date: Thu, 21 Jan 2010 16:34:58 +0100
In-Reply-To: <b90a809a1001201702y7d42eb60v43f24cb1043a89fa@mail.gmail.com>
	(=?utf-8?B?IuaZrwnmlofmnpciJ3M=?= message of "Thu, 21 Jan 2010 09:02:47
	+0800")
Message-ID: <87iqavlbdp.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "=E6=99=AF=E6=96=87=E6=9E=97" =3D=3D =E6=99=AF=E6=96=87=E6=9E=97  <we=
nlinjing@gmail.com> writes:

 =E6=99=AF=E6=96=87=E6=9E=97> Hi,

 =E6=99=AF=E6=96=87=E6=9E=97> =C2=A0I `m working on a freescale-MPC8379eRDB=
 like board.And I want
 =E6=99=AF=E6=96=87=E6=9E=97> to trun off kernel message during bootup.

 =E6=99=AF=E6=96=87=E6=9E=97> =C2=A0I tried to=C2=A0 modify "console =3D XX=
X" argument in uboot but it
 =E6=99=AF=E6=96=87=E6=9E=97> did not work(It works on ARM). Kernel always =
print:

 =E6=99=AF=E6=96=87=E6=9E=97> "console [udbg0] enabled" =C2=A0=C2=A0 or=C2=
=A0=C2=A0 "console handover: boot
 =E6=99=AF=E6=96=87=E6=9E=97> [udbg0] -> real [ttyS1]"=C2=A0

 =E6=99=AF=E6=96=87=E6=9E=97> Does anybody know how can I turn off this udb=
g0?

It's currently not configurable. I sent a (not applied) patch to make it
configurable back in Dec 2008:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2008-December/066461.html

You can probably still get it to apply with a bit of fuzz.

--=20
Bye, Peter Korsgaard
