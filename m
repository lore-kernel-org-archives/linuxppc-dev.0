Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 45023B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:32 +1000 (EST)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id 34805DDFA9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 02:50:56 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id b25so93619rvf.9
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 09:50:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090630061847.GA24164@pengutronix.de>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 30 Jun 2009 10:50:34 -0600
Message-ID: <fa686aa40906300950m15b7d48av953c0c738f6bf0e7@mail.gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 30, 2009 at 12:18 AM, Wolfram Sang<w.sang@pengutronix.de> wrote=
:
>> +
>> + =A0 =A0 /* Force clear the data valid bit */
>> + =A0 =A0 in_be32(&psc_dma->psc_regs->ac97_data);
>> +
>
> No mutex involved here. I think this is either a seperate patch or it nee=
ds at
> least to be mentioned in the patch description.

Oops, that was sloppy.  Yes, I'll put this into a separate patch.  Thanks.

g.
