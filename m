Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 6C5D3DDED4
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 06:27:05 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so24530anc
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 11:27:04 -0800 (PST)
Message-ID: <fa686aa40711241127i80acb2fyf61c41ab965c3178@mail.gmail.com>
Date: Sat, 24 Nov 2007 12:27:04 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [PATCH 0/5] Review request: Cypress c67x00 OTG controller
In-Reply-To: <200711240957.35385.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071124001203.25361.99294.stgit@trillian.cg.shawcable.net>
	<200711240957.35385.david-b@pacbell.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/24/07, David Brownell <david-b@pacbell.net> wrote:
> On Friday 23 November 2007, Grant Likely wrote:
> >
> > This patch series is based on the c67x00 work done by Peter Korsgaard and
> > posted back in April this year.
>
> What's changed since that version?  Were the comments sent
> at that time addressed?

A lot has changes since that version.  I'm not sure if all the
comments at that time were addressed (as in it's been a while since
I've looked at them; I'll go back and take another look).

You can see my progression from Peter's version and my version here:

http://git.secretlab.ca/git/gitweb.cgi?p=linux-2.6-virtex.git;a=shortlog;h=virtex-c67x00-dev

The patches I posted are the consolidation of the series in that git tree.

Cheers,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
