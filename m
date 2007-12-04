Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id DAD00DDE25
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 01:21:24 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so853307anc
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Dec 2007 06:21:24 -0800 (PST)
Message-ID: <fa686aa40712040621r3103bae9hd900c23d48273360@mail.gmail.com>
Date: Tue, 4 Dec 2007 07:21:23 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH v2 2/2] [POWERPC] Use new machine_xxx_initcall hooks in
	platform code
In-Reply-To: <fa686aa40712040536h18bd60d3xf89af1f89f6a92ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071202061028.21193.39309.stgit@trillian.secretlab.ca>
	<20071202061033.21193.64818.stgit@trillian.secretlab.ca>
	<Pine.LNX.4.62.0712041320250.12181@pademelon.sonytel.be>
	<fa686aa40712040536h18bd60d3xf89af1f89f6a92ad@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, olof@lixom.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/4/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 12/4/07, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > On Sat, 1 Dec 2007, Grant Likely wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > This patch makes the platform code use the new machine-specific initcall
> > > hooks.  This has the advantage of not needing to explicitly test
> > > machine_is() at the top of every initcall function.
> >
> > You seem to have missed the PS3 *_initcall()s.
> > Probably because they test for firmware_has_feature(FW_FEATURE_PS3_LV1) instead
> > of machine_is(ps3).
>
> That's exactly why; I didn't know if 'machine_is(ps3)' was a suitable
> substitute so I left it alone.

On that topic; I left some pseries and iseries stuff alone also for
the same reason.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
