Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 00132DDEBA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 05:40:49 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so626815anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 10:40:48 -0800 (PST)
Message-ID: <fa686aa40712171040u55740962ha5b562c85b8bc998@mail.gmail.com>
Date: Mon, 17 Dec 2007 11:40:47 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 7/7] [POWERPC] Xilinx: Update booting-without-of.
In-Reply-To: <20071217182459.7972AAE804F@mail50-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1197589413-5965-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234151.D0B3DE80061@mail20-sin.bigfish.com>
	<fa686aa40712170719o29da3caew43d65225feea9ba@mail.gmail.com>
	<20071217182459.7972AAE804F@mail50-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/17/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> When the driver no longer requires the port number, it's easy to drop.
> Until then, I'll keep it in.
>
> Also, I'm not so sure that moving to completely generic names is really
> worth the effort...  All the 'semantically' interesting' information is
> already in the device tree somewhere else.  In the limit, the node name
> could just be a randomly generated string.  So now we have a matter of
> taste: what is the right amount of detail to put in so that someone who
> looks at the tree can easily understand what's going on, but not be
> overwhelmed?

True, but part of 'taste' is following the established OF conventions
such as the generic names  ( http://playground.sun.com/1275/practice/
).  Those conventions come directly from the lessons learned by real
open firmware over the years.  It's okay to break convention; but only
if you've got a *damn* *good* reason for doing so.  :-)

>  The xilinx ip name seems to usually do that almost as well as
> a 'generic name'.  Anyway, you proved me wrong last time after a bunch of
> mulling it over, so maybe I'll just take your word for it and do it that
> way. :)

heh,   And a big reason I'm arguing it is David, Segher and others
took me to task for making the same mistakes.  :-)

> In other news, my computer seems to have died this morning, so productivity
> may be low. :)

Fun.  :-(

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
