Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.230])
	by ozlabs.org (Postfix) with ESMTP id 0B32ADDF09
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 16:15:37 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so2689488qbc.37
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 23:15:36 -0700 (PDT)
Date: Sun, 29 Jun 2008 00:15:33 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Rigby <jcrigby@gmail.com>
Subject: Re: [Resend][PATCH 1/8][Version 2] MPC5121 Update MPC5121ADS
	device tree
Message-ID: <20080629061533.GL13876@secretlab.ca>
References: <20080625203051.4FE882F123B@rumpole.eng.lineo.com>
	<20080627014233.GB17621@yookeroo.seuss>
	<4b73d43f0806262040s7993dcb7vd8a3d05793ea8a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4b73d43f0806262040s7993dcb7vd8a3d05793ea8a7@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 09:40:57PM -0600, John Rigby wrote:
> On Thu, Jun 26, 2008 at 7:42 PM, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Wed, Jun 18, 2008 at 02:24:46PM -0600, John Rigby wrote:
> >>       soc@80000000 {
> >>               compatible = "fsl,mpc5121-immr";
> >> +             device_type = "soc";
> >
> > I realise we still need the unwanted device_type value on the soc in
> > some cases for backwards compatibility, but why are you adding it
> > where it wasn't before..?
> >
> Because get_immrbase in fsl_soc.c does not work without it.

I think I'd rather see get_immrbase() instead then.

g.
