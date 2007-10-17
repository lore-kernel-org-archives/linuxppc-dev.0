Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.237])
	by ozlabs.org (Postfix) with ESMTP id 19AD2DDE43
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 00:57:20 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1566479nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 07:57:19 -0700 (PDT)
Message-ID: <fa686aa40710170757v694a001av8a3e95acbdf37bde@mail.gmail.com>
Date: Wed, 17 Oct 2007 08:57:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 01/15] [POWERPC] TQM5200 DTS
In-Reply-To: <4715ED92.80503@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com> <4708BFDD.9020900@semihalf.com>
	<fa686aa40710071036u164f2cbaob8cfa4ebc0b1ed1c@mail.gmail.com>
	<4715ED92.80503@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/17/07, Marian Balakowicz <m8@semihalf.com> wrote:
> Grant Likely wrote:
> >> +       memory {
> >> +               device_type = "memory";
> >> +               reg = <00000000 04000000>;      // 64MB
> >> +       };
> >> +
> >> +       soc5200@f0000000 {
> >
> > I think we're moving to the convetion of naming these nodes
> > "soc@<addr>" now.  (You can drop the 5200 for the node name)
>
> Seems that this will not be painless, U-boot uses hardcoded
> paths with 'soc5200', so the appropriate patch will be needed.
> That may be ok for new boards but what do we do with lite5200,
> where U-boot upgrade is not always an option?

Hmm; yeah I guess there are probably already deployed tqm5200 boards
with hard coded soc5200.  Alright; leave it as is.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
