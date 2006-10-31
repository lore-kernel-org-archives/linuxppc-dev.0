Return-Path: <pantelis.antoniou@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 1EA3367CBB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 20:05:03 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so1209159ugc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 01:04:59 -0800 (PST)
In-Reply-To: <200610310858.28622.laurent.pinchart@tbox.biz>
References: <200610261002.44688.laurent.pinchart@tbox.biz>
	<200610301623.51537.laurent.pinchart@tbox.biz>
	<20061030184002.35611755@vitb.ru.mvista.com>
	<200610310858.28622.laurent.pinchart@tbox.biz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <72741853-734F-4931-8567-5FBA3CB6FF42@gmail.com>
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: [PATCH] CPM UART: Fix break generation
Date: Tue, 31 Oct 2006 11:04:53 +0200
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On 31 =CE=9F=CE=BA=CF=84 2006, at 9:58 =CE=A0=CE=9C, Laurent Pinchart =
wrote:

> When generating a break condition on a serial port, the CPM must be =20=

> told
> beforehand how long the break should be. Unfortunately, this =20
> information is
> not available through the current serial break handling API. This =20
> patch works
> around the problem by requesting a 32767 characters break followed =20
> by a 0
> characters break after the requested duration. The CPM will stop =20
> the first
> break when the second one is requested. This might not work with =20
> future CPM
> revisions.
>

ACK,

Nice one Laurent ;)

Regards

Pantelis
