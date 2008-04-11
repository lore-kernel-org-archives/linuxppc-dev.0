Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id C9755DE3FE
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 00:28:23 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so568748wxd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 07:28:21 -0700 (PDT)
Message-ID: <fa686aa40804110728m9c5417ale80ccba984782513@mail.gmail.com>
Date: Fri, 11 Apr 2008 08:28:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] OF helpers for the GPIO API
In-Reply-To: <20080411130645.GB12655@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080411130537.GA10608@polina.dev.rtsoft.ru>
	<20080411130645.GB12655@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 7:06 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> This patch implements various helpers to support OF bindings for
>  the GPIO LIB API.
>
>  Previously this was PowerPC specific, but it seems this code
>  isn't arch-dependent anyhow, so let's place it into of/.
>
>  SPARC will not see this addition yet, real hardware seem to not use
>  GPIOs at all. But this might change:
>
>    http://www.leox.org/docs/faq_MLleon.html
>
>  "16-bit I/O port" sounds promising. :-)
>
>  Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Looks pretty sane to me.  Only nitpick; the documentation should be part of this
patch, not the next one; but I have no complaints if they both get
picked up at the same time.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
