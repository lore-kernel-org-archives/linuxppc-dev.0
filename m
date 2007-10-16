Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id E67A5DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 06:14:57 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2683264wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 13:14:57 -0700 (PDT)
Message-ID: <fa686aa40710161314m1cbc9c72w79d15c0d2ebebacf@mail.gmail.com>
Date: Tue, 16 Oct 2007 14:14:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "T Ziomek" <ctz001@email.mot.com>
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <Pine.LNX.4.64.0710161511280.22843@gauley.ddna.labs.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
	<13239003.post@talk.nabble.com>
	<fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
	<Pine.LNX.4.64.0710161511280.22843@gauley.ddna.labs.mot.com>
Cc: aauer1 <aauer1@gmx.at>, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/16/07, T Ziomek <ctz001@email.mot.com> wrote:
> On Tue, 16 Oct 2007, Grant Likely wrote:
> >
> > There are two common reasons for this behaviour:
> > 1. kernel crashes before the console is configured
> > 2. the console is not configured correctly.
> >
> > In both cases; finding a way to look at __log_buf is the fastest way
> > to figure out what is going on.
>
> Woah.  Grant's [good] advise notwithstanding, I'm confused

In what way?

>
> --
>    /"\  ASCII Ribbon Campaign   |
>    \ /                          |   Email to user 'CTZ001'
>     X        Against HTML       |             at 'email.mot.com'
>    / \     in e-mail & news     |
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
