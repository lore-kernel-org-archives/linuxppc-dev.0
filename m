Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id F08DCDE341
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 22:21:06 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1081505wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 03:21:05 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <496ED504.5040403@intel.com>
References: <1231944284-18296-1-git-send-email-jacmet@sunsite.dk>
	<496E0E85.7060801@freescale.com> <87iqohc19b.fsf@macbook.be.48ers.dk>
	<496E1317.9070804@freescale.com> <87eiz5c074.fsf@macbook.be.48ers.dk>
	<496E15E8.2060106@freescale.com> <87ab9tbsac.fsf@macbook.be.48ers.dk>
	<496E3D5D.5060701@freescale.com> <496ED504.5040403@intel.com>
Date: Thu, 15 Jan 2009 19:21:04 +0800
Message-ID: <2a27d3730901150321p4e5dcd50p16ddb0ccee5bc5bf@mail.gmail.com>
Subject: Re: [PATCH] fsldma: print correct IRQ on mpc83xx
From: Li Yang <leoli@freescale.com>
To: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: zw@zh-kernel.org, Timur Tabi <timur@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2009 at 2:17 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> Timur Tabi wrote:
>>
>> Peter Korsgaard wrote:
>>
>>> The only minor issues we have is the cosmetic problem of the driver
>>> printing NO_IRQ (E.G. this patch), and the driver calling
>>> free_irq(NO_IRQ) (E.G. the other patch I sent today) in the release
>>> path.
>>
>> Ok, I understand.
>>
>> ACK on the patches.
>>
>
> Ok, Li Yang and Zhang Wei have been silent recently on fsldma patches.
> Applied to async_tx.git/fixes

Sorry for the delay, was trapped by an upcoming release.

For the two patches from Peter,

Acked-by: Li Yang <leoli@freescale.com>

- Leo
