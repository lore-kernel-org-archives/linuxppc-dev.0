Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id 96A36DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 03:24:01 +1000 (EST)
Received: by qyk29 with SMTP id 29so1533460qyk.17
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 10:23:59 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20090420155511.GA25470@ld0162-tx32.am.freescale.net>
References: <49EC6CB5.2020300@kobekara.com>
	<20090420155511.GA25470@ld0162-tx32.am.freescale.net>
Date: Mon, 20 Apr 2009 12:23:52 -0500
Message-ID: <ed82fe3e0904201023q120e7ae1o7f4a4ddeb36d1e27@mail.gmail.com>
Subject: Re: MPC8349E's DMA controller like ISA controller but with more
	feature?
From: Timur Tabi <timur@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, lhthanh <lhthanh@kobekara.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 20, 2009 at 10:55 AM, Scott Wood <scottwood@freescale.com> wrot=
e:

> No. =A0It is for software-directed memory-to-memory transfers (where
> "memory" can be main-memory, or the buffer of a device that doesn't do
> DMA itself).

It can also be used to transfer data to/from a single I/O register,
which is how ISA DMA is frequently used.

--=20
Timur Tabi
Linux kernel developer at Freescale
