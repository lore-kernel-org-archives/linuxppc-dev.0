Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id E31C8DE67B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:06:12 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so807338wri
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:06:11 -0700 (PDT)
Message-ID: <fa686aa40710150706v1175b23bg83d8ee12e939cc8d@mail.gmail.com>
Date: Mon, 15 Oct 2007 08:06:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/7] rheap: Changes config mechanism
In-Reply-To: <5D5FEAFA-AFB9-4F8D-941E-11686E8992F4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044154.23438.58701.stgit@trillian.cg.shawcable.net>
	<751956FC-6B75-416C-A62A-67915652EA51@kernel.crashing.org>
	<fa686aa40710150655s37d8c7d5ye9122034f768a897@mail.gmail.com>
	<5D5FEAFA-AFB9-4F8D-941E-11686E8992F4@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Oct 15, 2007, at 8:55 AM, Grant Likely wrote:
>
> > On 10/15/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> >>
> >> On Oct 13, 2007, at 11:41 PM, Grant Likely wrote:
> >>
> >>> From: Sylvain Munaut <tnt@246tNt.com>
> >>>
> >>> Instead of having in the makefile all the option that
> >>> requires rheap, we define a configuration symbol
> >>> and when needed we make sure it's selected.
> >>>
> >>> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> >>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >>> ---
> >>>
> >>> +
> >>> +config PPC_LIB_RHEAP
> >>
> >> we should really have help for this option.
> >
> > This is a non-user-selectable option; none of the other
> > non-user-selectable options have help text.
>
> I don't see why we can't let users select it (saying that
> differently, we should let users have this ability)

Sure; but not in this patch.  This patch just changes from one fixed
method for selecting rheap to another.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
