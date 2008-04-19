Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id D1FCCDE548
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 01:55:59 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so278396anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 08:55:58 -0700 (PDT)
Message-ID: <fa686aa40804190855pa178b42h6f9493b064f728ba@mail.gmail.com>
Date: Sat, 19 Apr 2008 09:55:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] [POWERPC] mpc5200: Switch mpc5200 dts files to dts-v1
	format
In-Reply-To: <20080419133658.GJ13814@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080418160812.11897.5654.stgit@trillian.secretlab.ca>
	<20080419133658.GJ13814@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Sascha Hauer <sha@pengutronix.de>, m8@semihalf.com,
	Wolfram Sang <wsa@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 19, 2008 at 7:36 AM, Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
> On Fri, Apr 18, 2008 at 09:10:04AM -0700, Grant Likely wrote:
>  > Update dts files to current format
>
>  Is it somehow possible that this device tree stuff is *not* changed over
>  and over again and break everything out there? When people have not even
>  agreed on basic things like decimal vs. hex numbers, the whole idea
>  should be developed out-of-tree, then stabilize and *then* be submitted
>  to the Linux mainline.
>
>  Is it also really necessary to change like "gpt" vs. "timer" and "pic"
>  vs. "interrupt-controller" all the time? If you compare the last
>  mainline kernels, each one got a fundamental change in the naming, each
>  time breaking anyone who doesn't have his stuff in the mainline yet.
>
>  Sorry, but this is simply annoying, and the whole "the only thing we
>  have to do is to define it once and be done then" is crap.

Changing to dts-v1 does *not* break old stuff.  It is just a source
format change.

Neither does the RFC patch for removing the fsl,mpc5200b- compatible strings.

I have no intention of breaking older device trees.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
