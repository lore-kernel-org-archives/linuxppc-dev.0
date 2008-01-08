Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 91819DDF84
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:53:38 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1627194anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 09:53:37 -0800 (PST)
Message-ID: <fa686aa40801080953y14ecdc60i8c2418ba8d6e809a@mail.gmail.com>
Date: Tue, 8 Jan 2008 10:53:32 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] add default device trees for MPC837x MDS board
In-Reply-To: <20080108173845.GA5188@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
	<fa686aa40801080758o35dce96ej5db45576769561a5@mail.gmail.com>
	<20080108173845.GA5188@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/8/08, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, Jan 08, 2008 at 08:58:17AM -0700, Grant Likely wrote:
> > On 1/7/08, Li Yang <leoli@freescale.com> wrote:
> > > +                       phy_type = "utmi_wide";
> >
> > fsl,phy_type please.
>
> Again, code will break.  Can we stop ambushing people submitting board
> support with complaints against existing, non-board-specific code/device
> trees?  Fix that first, then complain if new code reintroduces the crud.

I disagree (about bringing up these comments).  New board port is the
time to bring these issue up.  It keeps the issue in the forefront so
it actually gets fixed.

>
> Also, if we're going to change the property name, we should also change the
> underscore to a dash.

Good point, I missed that

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
