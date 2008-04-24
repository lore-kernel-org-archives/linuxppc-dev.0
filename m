Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.239])
	by ozlabs.org (Postfix) with ESMTP id 6D6DDDE44C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 01:13:46 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2768845wxd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 08:13:45 -0700 (PDT)
Message-ID: <fa686aa40804240813p66889769y3bee6eb0111741f7@mail.gmail.com>
Date: Thu, 24 Apr 2008 09:13:45 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: mpc5200b custom board upstreamable?
In-Reply-To: <20080424151237.GI6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080424151237.GI6692@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 9:12 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
>  Hi all,
>
>  I had the intention to push the code for a custom mpc5200b board (freely
>  available, no internal project) upstream. After cleaning up the code I
>  realized that actually no board specific code is left and our board is
>  well handled by the mpc5200_simple_platform machine.
>
>  The only issue is that the machine only matches things like
>  "schindler,cm5200", there's no generic entry. Would it be possible to
>  add a "generic-mpc52xx" entry to this list?

I'm being cautious about this for the time being.  I'd like to have a
generic match mechanism, but I don't want to do something that isn't
easy to recover from if it turns out to be brain dead.  For now, just
add your board name to the explicit match list.

>
>  Another question: are defconfig and dts files for custom boards acceptable
>  for upstream?

Yes, in the arch/powerpc/configs/52xx/ directory.

Cheers,
g

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
