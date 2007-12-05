Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 86CAADDFDB
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 11:05:48 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so928630anc
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Dec 2007 16:05:23 -0800 (PST)
Message-ID: <fa686aa40712041605g642f1f73p59bb945ecacf6324@mail.gmail.com>
Date: Tue, 4 Dec 2007 17:05:23 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [XILINX][HWICAP] Xilinx Internal Configuration Access
	Port device driver.
In-Reply-To: <20071204235725.61AD6A08071@mail81-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071204235725.61AD6A08071@mail81-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/4/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> Supports static platform_device and static device tree configuration.
> This is a standalone driver that does not depend on EDK generated
> files.  However, it is also somewhat different in functionality from
> the standard EDK driver.
>
> 1) The EDK driver doesn't support readback, which this driver does.
> 2) The EDK driver supports fine granularity reading and writing, which
> this driver does not.  The fine granularity support is heavily
> architecture independent, which makes it difficult to make the driver
> forward compatible.  The fine granularity support is also complex and
> probably better handled in user space anyway.
>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> ---
>
> Grant,
>
> No comments last time... It would be nice if this merged with 2.6.25, I think.

Sorry Steve, I must have missed it.  I'll review and comment.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
