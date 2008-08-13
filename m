Return-Path: <plasmaroo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id D7003DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 15:57:40 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5549898wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 22:57:39 -0700 (PDT)
Message-ID: <792f5f410808122257t3711eb2lfc1e02bacade16a3@mail.gmail.com>
Date: Wed, 13 Aug 2008 06:57:39 +0100
From: "Tim Yamin" <plasm@roo.me.uk>
Sender: plasmaroo@gmail.com
To: "Daniel Schnell" <daniel.schnell@marel.com>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB03203B75@is-hdq-exchange.marel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <DD39B5C3F4963040ADC9768BE7E430CB03202F4F@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB0320387D@is-hdq-exchange.marel.net>
	<792f5f410808111431g8fafba1n3b10468da0d165bf@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203A7B@is-hdq-exchange.marel.net>
	<792f5f410808120643md72e679o39692c4bfa3f285e@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203A94@is-hdq-exchange.marel.net>
	<792f5f410808120730j7b4be4f2n7a40de880178ccca@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203ADC@is-hdq-exchange.marel.net>
	<792f5f410808120830v311e0446kc8fddfb97d0b9ea6@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203B75@is-hdq-exchange.marel.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 12, 2008 at 6:30 PM, Daniel Schnell
<daniel.schnell@marel.com> wrote:
> Hi Tim,
>
> Continuing the discussion on the mailing list ...
>
> Looking at the original patch I don't undestand why you had to duplicate
> the bestcomm data structures and functions. The only apparent difference
> is that you have a minimal data length of 2 bytes instead of 1. Does
> this make any difference as the bd_size will be filled with the correct
> length value anyway ?

The "new" version of the patch does this the correct way. I just
haven't back ported this to the 2.6.24 version that I sent you.

Tim
