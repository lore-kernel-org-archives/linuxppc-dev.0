Return-Path: <pku.leo@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id 995F0DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 17:49:09 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so399931rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 22:49:07 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1c641bc80902251151v5a4a5e15g13f6711510acb7ee@mail.gmail.com>
References: <1c641bc80902251151v5a4a5e15g13f6711510acb7ee@mail.gmail.com>
Date: Thu, 26 Feb 2009 14:43:06 +0800
Message-ID: <2a27d3730902252243i6e0e65f6te78831cfcbae823b@mail.gmail.com>
Subject: Re: MPC8313E-RDB and USB OTG
From: Li Yang <leoli@freescale.com>
To: Michael Bergandi <mbergandi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2009 at 3:51 AM, Michael Bergandi <mbergandi@gmail.com> wrote:
> Hi all,
>
> I am hoping someone can shed some light on the state of the USB support in
> the
> 2.6.28 kernel for USB OTG on the MPC8313E RDB. The configuration options are
> a bit different than the ones from the provided LTIB kernel--- for obvious
> reasons---
> and I am trying to figure out how to get OTG working in this version of the
> kernel
> on my board.

USB OTG support for Freescale USB has not been included in mainline.
So you need to bring the OTG code up-to-date, or stay with the LTIB
kernel.

- Leo
