Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 690B9DEE3F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 06:49:56 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so376714ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:49:54 -0700 (PDT)
Message-ID: <9e4733910807311349l5770a17ib2ab2535bcd2868a@mail.gmail.com>
Date: Thu, 31 Jul 2008 16:49:49 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Board level compatibility matching
In-Reply-To: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> This topic keeps coming up, so it is probably time to address it once
>  and for all.
>
>  When it comes to machine level support in arch/powerpc, there seems to
>  me that there are two levels or machine support.
>
......
>
>  Thoughts?
>  g.


As part of this, how can we going to solve the problem with triggering
the load of a board specific machine/fabric driver in a generic way?

-- 
Jon Smirl
jonsmirl@gmail.com
