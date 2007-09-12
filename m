Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.235])
	by ozlabs.org (Postfix) with ESMTP id 25C2BDDE41
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 02:02:20 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so228996qbe
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 09:02:19 -0700 (PDT)
Message-ID: <fa686aa40709120902q28d4d8bcr93020005dcf4f6f7@mail.gmail.com>
Date: Wed, 12 Sep 2007 10:02:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: Patches for 2.6.24
In-Reply-To: <B658701C-576E-459B-9FF4-BF43B429FCBB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40709120848x4720554jc46c8cd9ae3f355@mail.gmail.com>
	<B658701C-576E-459B-9FF4-BF43B429FCBB@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/12/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Sep 12, 2007, at 10:48 AM, Grant Likely wrote:
>
> > Kumar, can you please pick up the following patches and push them
> > to paulus?
> >
> > http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11303
>
> I'll hand this one.
>
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13235
> > http://patchwork.ozlabs.org/linuxppc/patch?id=13249
>
> bootwrapper patches should be ack'd by david gibson and picked up by
> paul at this point.

Okay, David has already acked these.  Paulus, can you please pick them up?

Thanks,
g.

>
> Did you have some other 834x defconfig updates as well?

I did; but it look like I need to rebase it again.  I'll try to get
that done today.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
