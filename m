Return-Path: <jcrigby@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 111A767B89
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 03:21:03 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id x4so1047798nfb
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 10:21:01 -0700 (PDT)
Message-ID: <4b73d43f0610191021y76eb6a04ydca2d73f90467c1@mail.gmail.com>
Date: Thu, 19 Oct 2006 11:21:00 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: status of mpc52xx with arch=powerpc?
In-Reply-To: <528646bc0610190746i78068543mf343d19167a38f97@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061018130628.GE6202@localhost.localdomain>
	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
	<20061019081337.GF6202@localhost.localdomain>
	<200610191149.10873.roman.fietze@telemotive.de>
	<528646bc0610190746i78068543mf343d19167a38f97@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Last time I offered to help Sylvain with the migration to powerpc he said:

>Frankly ... I don't know, I don't get how this new thing works ...
>if you figure it out, be my guest do it and explain it to me ;)

>It would be great because I get this cleaned API sitting on my
>tree along with the IDE DMA and the FEC code that I'd really
>like to send ...

Unfortunately I haven't been able to work on it either.

On 10/19/06, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 10/19/06, Roman Fietze <roman.fietze@telemotive.de> wrote:
> > Could you both double check e.g. with Sylvain Munaut at
>
> If Sylvain is around and has available bandwidth, I'm sure he is
> monitoring this list.
>
> > There are many drivers (git heads) available already, including IDE,
> > FEC, and so on. There's also new BestComm/FEC/IDE code from Dale
> > Farnsworth and John Rigby (Freescale) somewhere on the net.
>
> Yes, I'm using those patches; but they don't help with getting the
> mpc52xx moved over to arch/powerpc
>
> --
> Grant Likely, B.Sc. P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
