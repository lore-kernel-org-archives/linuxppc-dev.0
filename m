Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id E652EDDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:56:42 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1627442anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 09:56:41 -0800 (PST)
Message-ID: <fa686aa40801080956n20f31a54xe02328a139ac3a3b@mail.gmail.com>
Date: Tue, 8 Jan 2008 10:56:41 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
In-Reply-To: <20080108175513.GC5188@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<fa686aa40801080919y7c426007vd031bb79e8f9a03d@mail.gmail.com>
	<20080108175513.GC5188@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/8/08, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, Jan 08, 2008 at 10:19:20AM -0700, Grant Likely wrote:
> > > +config MPC5121_ADS
> > > +       bool "Freescale MPC5121E ADS"
> > > +       select DEFAULT_UIMAGE
> > > +       help
> > > +         This option enables support for the MPC5121E ADS board.
> >
> > Make this depend on PPC_MULTIPLATFORM and PPC32
>
> I don't think PPC_MULTIPLATFORM is appropriate here... it seems to be
> OF-specific.

52xx is multiplatform.  It works well on both OF and non-OF boards.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
