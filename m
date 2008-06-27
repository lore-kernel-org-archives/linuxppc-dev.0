Return-Path: <Monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id C906DDDF01
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 00:48:06 +1000 (EST)
In-Reply-To: <alpine.LFD.1.10.0806271240461.3297@apollo.tec.linutronix.de>
Date: Fri, 27 Jun 2008 15:10:32 +0200 (CEST)
To: =?us-ascii?Q?Thomas=20Gleixner?= <tglx@linutronix.de>
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5BPATCH=2026=2F60=5D=20microblaze=5Fv4=3A=20time=20support?=
Mime-Version: 1.0
Message-Id: <4641.7464-1217-45420265-1214572232@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	=?us-ascii?Q?Michal=20Simek?= <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +
>> +static inline void udelay(unsigned long usec)
>> +{
>> +}
>
>shouldnt this function be named zerodelay() ?
>
>Thanks,
>	tglx

I have prepared implementation of this function which sent me JW.
I did some changes which I test it because I found problem there. 

M
