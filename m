Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id AAE22DDECB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 04:52:32 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1145272anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 09:52:31 -0800 (PST)
Message-ID: <fa686aa40801030952j7f842232ke1078ef04bbb32d9@mail.gmail.com>
Date: Thu, 3 Jan 2008 10:52:31 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 4/5] [POWERPC] 8xx: Use machine_*_initcall() hooks in
	platform code
In-Reply-To: <20080103173717.GA4287@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
	<20080102193233.24178.74501.stgit@trillian.secretlab.ca>
	<20080103173717.GA4287@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/3/08, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, Jan 02, 2008 at 12:32:51PM -0700, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> >  arch/powerpc/platforms/8xx/ep88xc.c          |    5 ++---
> >  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 ++---
>
> How about mpc86xads_setup.c?

Oops.  I fixed that one too, but it's in the 8xxx patch by mistake.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
