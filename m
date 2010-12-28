Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id AB2EEB70DF
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Dec 2010 02:39:10 +1100 (EST)
Subject: Re: PMU_IOC_SLEEP failed
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: jjDaNiMoTh <jjdanimoth@gmail.com>
In-Reply-To: <AANLkTiksBGDR=vJLArgShP8U_NWZ2OWXc65wiXRLv4kr@mail.gmail.com>
References: <AANLkTiksBGDR=vJLArgShP8U_NWZ2OWXc65wiXRLv4kr@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Dec 2010 16:32:33 +0100
Message-ID: <1293550353.19556.224.camel@thor.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Die, 2010-12-28 at 13:25 +0100, jjDaNiMoTh wrote:=20
>=20
> what could be the problem here?
>=20
> [root@myhost ~]# /usr/lib/hal/hal-system-power-pmu sleep
> power-pmu : PMU_IOC_SLEEP failed
>=20
> (same with pm-suspend, kernel version: any >=3D 2.6.33. I'm now on a .37-=
rc).
>=20
> KMS is disabled (modprobe radeon modeset=3D0, and I can't switch over VT)=
.

What exactly does "can't switch over VT" mean?

Sleep requires radeonfb, is that enabled?


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
