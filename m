Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 15AA4DDF54
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 00:20:13 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2163793wag
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Oct 2007 07:20:12 -0700 (PDT)
Message-ID: <fa686aa40710090720g5b39550cxa89773b0088fe26@mail.gmail.com>
Date: Tue, 9 Oct 2007 08:20:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/6] Platforms shouldn't mess with ROOT_DEV
In-Reply-To: <E82FBA5B-61A0-4A0A-886B-0FCDD6AFC255@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
	<20071008222503.25840.37660.stgit@trillian.cg.shawcable.net>
	<E82FBA5B-61A0-4A0A-886B-0FCDD6AFC255@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/9/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Oct 8, 2007, at 5:25 PM, Grant Likely wrote:
>
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > There is no good reason for board platform code to mess with the
> > ROOT_DEV.
> > Remove it from all in-tree platforms except powermac
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> >  arch/powerpc/platforms/52xx/efika.c          |    9 ---------
> >  arch/powerpc/platforms/52xx/lite5200.c       |   12 ------------
> >  arch/powerpc/platforms/8xx/mpc86xads_setup.c |    2 --
> >  arch/powerpc/platforms/cell/setup.c          |    5 -----
> >  arch/powerpc/platforms/celleb/setup.c        |    5 -----
> >  arch/powerpc/platforms/chrp/setup.c          |   10 ----------
> >  arch/powerpc/platforms/pseries/setup.c       |    5 -----
> >  7 files changed, 0 insertions(+), 48 deletions(-)
>
> I'd drop mpc86xads_setup since I think Scott's rework will deal with it.

Okay, will do.  I wasn't sure since you hadn't explicitly mentioned it.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
