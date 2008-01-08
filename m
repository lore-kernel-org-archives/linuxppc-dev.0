Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 9C46ADE0A3
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 08:40:31 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1645924anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 13:40:30 -0800 (PST)
Message-ID: <fa686aa40801081340l1eed359arf345b020b4a410a0@mail.gmail.com>
Date: Tue, 8 Jan 2008 14:40:30 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: Generic desktop/server/laptop lable is confusing [Was Re: [PATCH
	3/7] Basic Freescale MPC512x support]
In-Reply-To: <4783DF12.9050700@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<fa686aa40801080919y7c426007vd031bb79e8f9a03d@mail.gmail.com>
	<20080108175513.GC5188@loki.buserror.net>
	<fa686aa40801080956n20f31a54xe02328a139ac3a3b@mail.gmail.com>
	<20080108192531.GB5296@loki.buserror.net>
	<4783DF12.9050700@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/8/08, John Rigby <jrigby@freescale.com> wrote:
>
> >
> > It may work, but it pulls in code like prom_init.c that is not needed on
> > non-OF boards.  It's also quite confusing to have an embedded board's
> > checkbox only show up when you say yes to "Generic desktop/server/laptop".
> >
> I have to agree with this, I have been confused by this myself.
> Perhaps the prompt should be changed to something less
> confusing?

I'm agreeable to that.  Maybe simply "Multiplatform" with a better
description in the help text?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
