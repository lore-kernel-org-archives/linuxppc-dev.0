Return-Path: <timur.tabi@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id EDB99B6F0E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 01:00:06 +1000 (EST)
Received: by pxi1 with SMTP id 1so240216pxi.15
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 08:00:05 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <4C1FB6BB.4040705@mlbassoc.com>
References: <4C1FB6BB.4040705@mlbassoc.com>
From: Timur Tabi <timur@freescale.com>
Date: Tue, 22 Jun 2010 09:51:33 -0500
Message-ID: <AANLkTinyt8phAgxJk30G0XuA5kJ78Xy1WdTg_yQpTCsS@mail.gmail.com>
Subject: Re: UCC interactions
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 21, 2010 at 2:00 PM, Gary Thomas <gary@mlbassoc.com> wrote:
> I'm running 2.6.33.3 on MPC8358. =A0I have UCC1+UCC2 working fine
> for ethernet, but when I add UCC3 as a UART, the network devices
> quit working.

Since you're using QE UART, would you mind testing this patch:

http://patchwork.ozlabs.org/patch/56181/

and letting us know if it works for you?

--=20
Timur Tabi
Linux kernel developer at Freescale
