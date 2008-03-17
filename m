Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 5CD68DDFE7
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:08:26 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so5261802hsz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 13:08:25 -0700 (PDT)
Message-ID: <fa686aa40803171308h5ef7f8a9m5119ef12d8c87980@mail.gmail.com>
Date: Mon, 17 Mar 2008 14:08:23 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: Boot: Fix 16550 UART initialization
In-Reply-To: <20080317195756.4F7411BE807D@mail119-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317164202.7E8A41A3806F@mail213-sin.bigfish.com>
	<fa686aa40803171247j709bc554pe709628c46205600@mail.gmail.com>
	<20080317195756.4F7411BE807D@mail119-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 1:57 PM, John Linn <John.Linn@xilinx.com> wrote:
> That makes sense.  Since I'm not using a boot loader I didn't realize
>  that.
>
>  I'm not sure how hard it will be to get the data from the device tree at
>  that time.

You should be good.  It is now possible to read data from the device
tree at platform_init() time.

Cheers,
g.

>  What about checking to see if it's setup assuming that's possible by
>  looking at registers, and then not messing with it if it's already
>  setup, otherwise do what my patch does.

Ugh.  The old arch/ppc code used to do this and it was kind of ugly
and fragile.  I'd rather avoid doing it again.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
