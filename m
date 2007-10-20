Return-Path: <Monstr@seznam.cz>
Received: from mxh.seznam.cz (mxh.seznam.cz [77.75.72.26])
	by ozlabs.org (Postfix) with SMTP id 57A75DDE40
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 17:05:57 +1000 (EST)
In-Reply-To: <fa686aa40710192247u294b9329p538bbaf715610040@mail.gmail.com>
Date: Sat, 20 Oct 2007 09:05:52 +0200 (CEST)
To: =?us-ascii?Q?Grant=20Likely?= <grant.likely@secretlab.ca>
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5Bmicroblaze=2Duclinux=5D=20RE=3A=20=5BPATCH=20v3=5D=20Device=20tree=20bindings=20for=20Xilinx=20devices?=
Mime-Version: 1.0
Message-Id: <1293.2647-29478-1639039305-1192863952@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: Leonid <Leonid@a-k-a.net>, =?us-ascii?Q?Arnd=20Bergmann?= <arnd@arndb.de>,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	=?us-ascii?Q?Wolfgang=20Reissnegger?= <wre@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

>> Hi Steve and all,
>> >Here's a full .dts generated using an updated version of
>> >gen_mhs_devtree.py, following the proposal.
>> >It happens to be a microblaze system, but you get the idea.
>>
>> I think that is no good idea generate dts with all information.
>> Especially information about PVR - number 2 means - Full PVR and you can
>> obtain information directly from PVR. It is waste of memory space.
>>                         xilinx,pvr = <2>;
>>
>> In my opinion will be better generate only parameters which you want not all.
>> That smells with unusable parameters.
>
>That is the hard part about crafting the dts; deciding which
>parameters the OS is going to care about and which ones are
>irrelevant.  The goal is to sufficiently and uniquely describe the
>board so that the OS can easily figure out what exactly what it needs
>to do to drive the board, but not to try and describe every aspect
>which it knows about.  Anything that is pollable (ie. USB devices)
>doesn't need to be in the tree.
>
>It's also important to remember that the device tree will *never* be
>perfect.  Eventually something will come up that the device tree
>doesn't describe well(a bug/quirk, something described poorly, etc).
>In this case, as long as the device tree is specific enough to
>identify which version of the board it is running on; we can alwasy
>add platform specific fixups for that unique system.
>

yes, but I think that is the right time to specify which parameters are relevant.
I will focus on in EDK renerator.

Michal Simek
