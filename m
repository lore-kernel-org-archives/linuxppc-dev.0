Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 61BE2DDEA2
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 17:59:14 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so295545anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 22:59:13 -0800 (PST)
Message-ID: <fa686aa40801182259k22663ca9s74b109f0f15d11fd@mail.gmail.com>
Date: Fri, 18 Jan 2008 23:59:13 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [Add mpc5121 support PATCH v3 7/8] Factor out 52xx dependencies
	from 52xx psc driver
In-Reply-To: <fa686aa40801182258r5a3b6465kf0e7918e0e56e0c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1200614738-25654-1-git-send-email-jrigby@freescale.com>
	<1200614738-25654-2-git-send-email-jrigby@freescale.com>
	<1200614738-25654-3-git-send-email-jrigby@freescale.com>
	<1200614738-25654-4-git-send-email-jrigby@freescale.com>
	<1200614738-25654-5-git-send-email-jrigby@freescale.com>
	<1200614738-25654-6-git-send-email-jrigby@freescale.com>
	<1200614738-25654-7-git-send-email-jrigby@freescale.com>
	<1200614738-25654-8-git-send-email-jrigby@freescale.com>
	<fa686aa40801182258r5a3b6465kf0e7918e0e56e0c4@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/18/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 1/17/08, John Rigby <jrigby@freescale.com> wrote:
> > PSCs change from 5200 to 5121
> > this patch localizes the differences in
> > preparation for adding 5121 support
> >
> > Signed-off-by: John Rigby <jrigby@freescale.com>
>
> This patch breaks the serial console on my Efika.

Er, more specifically, I get console output, but I get no output from
the init process (like when I add "init=/bin/sh" to the kernel
parameters).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
