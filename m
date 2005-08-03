Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 2AE7867E94
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 23:56:08 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so136681wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 03 Aug 2005 06:56:07 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Date: Wed, 3 Aug 2005 19:14:10 +0300
References: <42EF9022.5050707@ru.mvista.com>
	<200508030039.16107.pantelis.antoniou@gmail.com>
	<42F06F62.6050509@ru.mvista.com>
In-Reply-To: <42F06F62.6050509@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200508031914.10973.pantelis.antoniou@gmail.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] cpm_uart: Made non-console uart work
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 03 August 2005 10:16, you wrote:
> Panto, Kumar,
>
> Thank you for review.
>

[major snipage]

> Well, all the stuff works on 8272 even without this and likewise stuff,
> but don't on 866ADS, where bus_to_virt returns value not equal to where
> we allocated DMA. I didn't dig too deep to track why this happens, since
> if we're using DMA, we should remember addresses upon allocation and
> avoid using bus_to_virt.

Well, this is weird cause I've tested my latest patch on 8xx and had no 
problems...

I'll try to test your patch, some time later today.

However, what is important now is to get the fs_enet driver posted.
Please test the latest patch I've send you on a linus tree and report if you
have any problems...

Regards

Pantelis
