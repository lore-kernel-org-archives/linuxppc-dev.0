Return-Path: <plasmaroo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 6FF50DDEF5
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 22:18:15 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5845111wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 05:18:13 -0700 (PDT)
Message-ID: <792f5f410808060518r5e2c0124i2cfef450e264f012@mail.gmail.com>
Date: Wed, 6 Aug 2008 13:18:13 +0100
From: "Tim Yamin" <plasm@roo.me.uk>
Sender: plasmaroo@gmail.com
To: "Daniel Schnell" <daniel.schnell@marel.com>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB03202EDF@is-hdq-exchange.marel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <792f5f410806170128k7e435743x9892b559bd32b157@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03202EDF@is-hdq-exchange.marel.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 6, 2008 at 12:58 PM, Daniel Schnell
<daniel.schnell@marel.com> wrote:
> Hi,
>
> Sorry for testing this patch so late, but I get these if I apply your
> patch to 2.6.24.7 and use it with my Sandisk Extreme IV 4GB card:

Hi,

What board are you using? DMA requires a few more signals to be routed
through correctly to the CF card slot so maybe that's your problem...

Tim
