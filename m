Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id 3E816DDF15
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 07:13:02 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so4968649wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 13:13:01 -0700 (PDT)
Message-ID: <fa686aa40803171313o6c22c52fw7b231c7053dae7d6@mail.gmail.com>
Date: Mon, 17 Mar 2008 14:13:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: Boot: Fix 16550 UART initialization
In-Reply-To: <20080317201035.CBCAC1468068@mail95-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317164202.7E8A41A3806F@mail213-sin.bigfish.com>
	<fa686aa40803171247j709bc554pe709628c46205600@mail.gmail.com>
	<20080317195756.4F7411BE807D@mail119-dub.bigfish.com>
	<fa686aa40803171308h5ef7f8a9m5119ef12d8c87980@mail.gmail.com>
	<20080317201035.CBCAC1468068@mail95-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 2:10 PM, John Linn <John.Linn@xilinx.com> wrote:
> Great, I'll do that.
>
>  Does this also apply to my other patch, Adding 8250 console support to
>  OF serial, as it's not clear to me when to assume the UART is already
>  setup or not?

I haven't reviewed that one yet.  I'll get to it this afternoon.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
