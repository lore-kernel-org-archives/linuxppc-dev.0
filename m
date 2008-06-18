Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id D8D63DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 15:20:36 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so16826anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 22:20:34 -0700 (PDT)
Message-ID: <fa686aa40806172220u13d4397cn51f7f98e020408aa@mail.gmail.com>
Date: Tue, 17 Jun 2008 23:20:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH 1/2] fs_enet: fix checkpatch.pl problems
In-Reply-To: <1213743794-3537-2-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1213743794-3537-1-git-send-email-jrigby@freescale.com>
	<1213743794-3537-2-git-send-email-jrigby@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>, jeff@garzik.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 17, 2008 at 5:03 PM, John Rigby <jrigby@freescale.com> wrote:
> Fixed all errors and warnings that checkpatch.pl
> reports if this was a new submission.
> Also changed instances of fec_t to struct fec in
> mac-fec.c and mii-fec.c.

Nit: checkpatch is not law; particularly in the case of whitespace
change.  Personally, I think cleaning up whitespace in this regard
causes more problems than it solves.  Plus, it makes the important
change (fec_t -> struct fec) get lost in a see of unimportant ones
which makes for hard reviewing.

But I must sleep now; I'll review your other patch tomorrow.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
