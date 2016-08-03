Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s492761pkzDqQ4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 20:54:55 +1000 (AEST)
Message-ID: <1470221638.12584.82.camel@kernel.crashing.org>
Subject: Re: [pasemi] Radeon HD graphics card not recognised after the
 powerpc-4.8-1 commit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, luigi burdo
 <intermediadc@hotmail.com>, Darren Stevens <darren@stevens-zone.net>,
 Julian Margetson <runaway@candw.ms>,
 Steven Jeffery <sajeffer@gmail.com>, "R.T.Dickinson" <rtd@a-eon.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat Wall <pjwall@mac.com>,
 Pat Wall <pjwall@me.com>, "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>, Kevin
 Saunders <kfs1971@gmail.com>, Lyle Hazelwood <lylehaze@gmail.com>,
 EntwicklerX <mail@entwickler-x.de>, "xray@relec.ch" <xray@relec.ch>,
 Steve-David Marguet <steve@esdeem.ch>, George Sokianos <walkero@gmail.com>,
 Sinan =?ISO-8859-1?Q?G=FCrkan?= <sinan.amigaone@gmail.com>, Mike
 <michael.heltne@gmail.com>, Thomas Ferreira <macsociety@me.com>, Christian
 Zigotzky <info@xenosoft.de>, "pjs@pjsa.net" <pjs@pjsa.net>, Ben Cato
 Malkenes <ben.cato@gmail.com>, Olof Johansson <olof@lixom.net>, Michael
 Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 03 Aug 2016 20:53:58 +1000
In-Reply-To: <3fd5ecda-7e1f-52ec-6f11-ed603d2dcd76@xenosoft.de>
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <5773AEFD.6070608@xenosoft.de>
 <AM4PR01MB1538D5E894F612122B81991AC8230@AM4PR01MB1538.eurprd01.prod.exchangelabs.com>
 <57752BB3.9060306@xenosoft.de>
 <7072d7cf-4d73-d424-af20-f5e94c8b399e@xenosoft.de>
 <816DC2B4-5B33-4C5E-A09A-F5BF7C7BF1FD@xenosoft.de>
 <aed83bc1-e574-1a9f-de58-480c9164865c@xenosoft.de>
 <2d94a278-d1d8-b484-e9ca-aedf18051e1a@xenosoft.de>
 <a84c2b93-4dac-9148-9ae2-0824491d1f50@xenosoft.de>
 <ae855392-570c-e125-b71f-2d5bf0c33eef@xenosoft.de>
 <d869fc32-ba80-529e-06dd-481ecf533642@xenosoft.de>
 <8b0682d3-866a-31dd-f01b-3510f84307dc@xenosoft.de>
 <2847029a-e3a4-8099-b72f-89d5731baaed@xenosoft.de>
 <4e97a4dd-3fe0-84aa-47f0-29d1544c9f8c@xenosoft.de>
 <72eed836-767c-402a-576a-8049db34d281@xenosoft.de>
 <8878883b-bd51-b7c9-ee5b-927e481e5d30@xenosoft.de>
 <8a3764d2-7fc1-1967-f557-146a3df16894@xenosoft.de>
 <1d98af3c-f585-967b-1413-58d34fad20af@xenosoft.de>
 <f6a4c3c1-f452-f4fc-1d36-b2bed81f32a3@xenosoft.de>
 <3fd5ecda-7e1f-52ec-6f11-ed603d2dcd76@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-03 at 11:03 +0200, Christian Zigotzky wrote:
> I reverted the commit "powerpc-4.8-1" and Xorg works. The commit 
> "powerpc-4.8-1" is the problem.
> 
> Link: 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9
> 
> Which source code modification in the commit "powerpc-4.8-1" could be 
> the problem?

This is a merge, not a commit. Can you bisect down that branch ? Also
include the kernel dmesg log.

Cheers,
Ben.
