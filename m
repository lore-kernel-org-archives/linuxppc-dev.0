Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id CC24EDE9F9
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 07:57:16 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so30455anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 13:57:10 -0700 (PDT)
Message-ID: <fa686aa40803261357m4a8e8703u7f3b8e39199e1de7@mail.gmail.com>
Date: Wed, 26 Mar 2008 14:57:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/5] leds: implement OpenFirmare GPIO LEDs driver
In-Reply-To: <20080326202453.GC1772@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080326202453.GC1772@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 2:24 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Despite leds-gpio and leds-of-gpio similar names and purposes, there
>  is actually very few code can be shared between the two (both drivers
>  are mostly the driver bindings anyway).
>
>  Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Other than the fact that it needs some documentation of the binding in
booting-without-of.txt, it looks pretty good to me.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
