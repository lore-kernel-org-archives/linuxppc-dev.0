Return-Path: <Monstr@seznam.cz>
Received: from mxh.seznam.cz (mxh.seznam.cz [77.75.72.26])
	by ozlabs.org (Postfix) with SMTP id C7754DDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 12:28:32 +1000 (EST)
In-Reply-To: <20071019234347.38C1111C006B@mail3-dub.bigfish.com>
Date: Sat, 20 Oct 2007 04:28:26 +0200 (CEST)
To: microblaze-uclinux@itee.uq.edu.au
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5Bmicroblaze=2Duclinux=5D=20RE=3A=20=5BPATCH=20v3=5D=20Device=20tree=20bindings=20for=20Xilinx=20devices?=
Mime-Version: 1.0
Message-Id: <1300.2720-24480-247293449-1192847306@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: Leonid <Leonid@a-k-a.net>, =?us-ascii?Q?Arnd=20Bergmann?= <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org,
	=?us-ascii?Q?Wolfgang=20Reissnegger?= <wre@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Steve and all,
>Here's a full .dts generated using an updated version of
>gen_mhs_devtree.py, following the proposal.
>It happens to be a microblaze system, but you get the idea.

I think that is no good idea generate dts with all information.
Especially information about PVR - number 2 means - Full PVR and you can
obtain information directly from PVR. It is waste of memory space.
			xilinx,pvr = <2>;

In my opinion will be better generate only parameters which you want not all.
That smells with unusable parameters.

Michal Simek
