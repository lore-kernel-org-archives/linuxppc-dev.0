Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.233])
	by ozlabs.org (Postfix) with ESMTP id CBE60DDEC0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 23:09:18 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so40710nzh
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:09:17 -0700 (PDT)
Message-ID: <fa686aa40710190609jebd4e31q9240d2ff5b4a5d47@mail.gmail.com>
Date: Fri, 19 Oct 2007 07:09:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH] bestcomm: Restrict disabling of bus prefetch to original
	mpc5200 silicon.
In-Reply-To: <20071019112916.GE27403@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071017163555.24992.40095.stgit@trillian.cg.shawcable.net>
	<20071019112916.GE27403@nd47.coderock.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/19/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> On 17/10/07 10:36 -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Only the MPC5200 needs this bug fix.  MPC5200B is okay.
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> > Sven, Domen;
> >
> > Can you please test this patch?
>
> I found no obvious problems with it on Efika (mpc5200b)

Cool, I'll add it to my list of patches for Paulus to pull

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
