Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by ozlabs.org (Postfix) with ESMTP id 4266FDE376
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 02:36:12 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so68421wxd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 09:36:10 -0700 (PDT)
Message-ID: <fa686aa40804100936r3ef0a69en5fb092e1129f867f@mail.gmail.com>
Date: Thu, 10 Apr 2008 10:36:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>
Subject: Re: How to pass information from the bootloader to the kernel ?
In-Reply-To: <200804101751.00618.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200804101751.00618.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2008 at 9:50 AM, Laurent Pinchart
<laurentp@cse-semaphore.com> wrote:
> Hi everybody,
>
>  I need to pass a limited amount of information from the boot loader to the
>  Linux kernel, such as the boot mode chosen by the user or the last boot
>  reason (power up, reset, watchdog, ...).
>
>  What is the best way to pass that kind of information from the boot loader to
>  the kernel ? Should I use the device tree ?
>
>  I thought about populating the chosen node with the data I need. This could
>  make sense for the boot mode, but I feel like I would abuse the chosen node
>  if I used it to pass other "non user chosen" information.

Using the chosen node should be fine.  Just prefix your new properties
with your company name or something so that you don't get namespace
collisions.  However, whatever you do; document it first and post your
documentation to the mailing list for review.

Cheers,
g.


>
>  Best regards,
>
>  --
>  Laurent Pinchart
>  CSE Semaphore Belgium
>
>  Chaussee de Bruxelles, 732A
>  B-1410 Waterloo
>  Belgium
>
>  T +32 (2) 387 42 59
>  F +32 (2) 387 42 75
>
> _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
