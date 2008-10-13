Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 42B7DDE409
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:04:41 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m9DG4U30007381
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:04:31 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m9DG4Ux9002473
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:04:30 -0500 (CDT)
Date: Mon, 13 Oct 2008 11:04:29 -0500
From: Scott Wood <scottwood@freescale.com>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [RFC 1/6] [PWM] Generic PWM API implementation
Message-ID: <20081013160429.GA19080@ld0162-tx32.am.freescale.net>
References: <cover.1223482372.git.bgat@billgatliff.com>
	<4b5c3aa2b1bc2b7efad834da49c2dec8c0a8726b.1223482372.git.bgat@billgatliff.com>
	<1223608853.8157.129.camel@pasglop>
	<48EF61A2.3020006@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48EF61A2.3020006@billgatliff.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 09:07:30AM -0500, Bill Gatliff wrote:
> Benjamin Herrenschmidt wrote:
> > And you haven't provided -any- changeset comment. That isn't good :-)
> 
> What's the easiest way to do that with git?

Enter the changeset comment in git commit.

> I'm using git-format-patch and git-send-email to produce the changeset
> emails themselves, after extensive use of git-add --interactive and
> git-rebase --interactive to get rid of the "mundane" commit stuff that
> I do because of my highly interrupt-driven workflow.

If your final commit is generated from something other than git commit,
you can use git commit --amend to edit the comment.

-Scott
