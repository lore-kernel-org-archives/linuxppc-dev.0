Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xrT8528dczDrZ3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 23:20:52 +1000 (AEST)
Subject: Re: Hardware 3D acceleration doesn't work anymore after the PowerPC
 updates 4.14-1
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <421109ac-41f8-f332-068b-8884cf7322b6@xenosoft.de>
 <87vakpbn4d.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <2700b2a1-22a0-0c8e-2f5a-4778717db652@xenosoft.de>
Date: Mon, 11 Sep 2017 15:20:39 +0200
MIME-Version: 1.0
In-Reply-To: <87vakpbn4d.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

It works! :-)

I have successfully tested it with ubuntu MATE 16.04.3 LTS PowerPC (Mesa 
17.0.7 with an AMD Radeon HD4870) and with the MATE PowerPC Remix 2017 
(Mesa 17.0.1 with an AMD Radeon HD4870).

Many thanks for your help!

Cheers,
Christian


On 11 September 2017 at 11:28AM, Michael Ellerman wrote:
> Hi Christian,
>
> Can you try Linus' mainline, with just the following commit reverted:
> 31bfdb036f12 ("powerpc: Use instruction emulation infrastructure to handle alignment faults")
>
> So just:
>
> $ git revert 31bfdb036f12
>
> cheers
>
