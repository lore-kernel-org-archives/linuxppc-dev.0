Return-Path: <netstv@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 3C74A679F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 04:04:15 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id s49so45984pyc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 11:04:14 -0700 (PDT)
Message-ID: <b4b98b690605161104y1e77b92fje4b234356e863711@mail.gmail.com>
Date: Tue, 16 May 2006 11:04:12 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "Walter L. Wimer III" <walt.wimer@timesys.com>
Subject: Re: what does this mean?
In-Reply-To: <1147801367.14881.4.camel@excalibur.timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <b4b98b690605160951o5cefddd8t6b19a91a708f0431@mail.gmail.com>
	<1147801106.14881.2.camel@excalibur.timesys.com>
	<1147801367.14881.4.camel@excalibur.timesys.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks.  That's what I think it is, but I didn't write this code so
I'm trying to track down
who is calling down at interrupt time.



On 5/16/06, Walter L. Wimer III <walt.wimer@timesys.com> wrote:
> On Tue, 2006-05-16 at 13:38 -0400, Walter L. Wimer III wrote:
> > Check to make sure that in your interrupt handler you are not calling
> > something that can sleep.  E.g. sleep(), usleep(), kmalloc(),
> > vmalloc(), etc.
>
> Also watch out for semaphore operations such as down() and
> down_interruptible().  They can sleep too.
>
>
> Walt
>
>
>
