Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 5300DDDFB0
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 06:27:45 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so685906anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 12:27:39 -0700 (PDT)
Message-ID: <fa686aa40804021227r2f2bb4beje303578d6ea964a7@mail.gmail.com>
Date: Wed, 2 Apr 2008 13:27:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: [PATCH 2/3][POWERPC][V2] Xilinx: of_serial support for Xilinx
	uart 16550.
In-Reply-To: <20080402182023.8FA7318B808D@mail52-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12071551351007-git-send-email-john.linn@xilinx.com>
	<12071551354058-git-send-email-john.linn@xilinx.com>
	<20080402165222.2468414080A9@mail104-dub.bigfish.com>
	<fa686aa40804021100j13a7e223jde9d222df379b1f8@mail.gmail.com>
	<20080402182023.8FA7318B808D@mail52-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 2, 2008 at 12:20 PM, John Linn <John.Linn@xilinx.com> wrote:
> Sounds good, those are easy changes and make sense.
>
>  Since I'm a newbie, I don't know any better sometimes when I copy other
>  code that may not be as safe.
>
>  The same thing, of_get_property(np, "current-speed", NULL);, is done
>  right above my code I added.
>
>  Should the other code in the driver using the same method be fixed, or
>  just my patch?

It would be good to fix the other code, but not in this patch.  Write
another patch to fix that.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
