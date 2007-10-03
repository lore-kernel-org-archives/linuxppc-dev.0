Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id 72E76DDE48
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:57:37 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so3252841nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 08:57:36 -0700 (PDT)
Message-ID: <fa686aa40710030857g467a8e13gcee1a19d38e31f9c@mail.gmail.com>
Date: Wed, 3 Oct 2007 09:57:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_spi devices should use mode "cpu" or "qe"
In-Reply-To: <085BE1E4-945F-4690-9DFC-627F242831A6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <87przwxkzf.fsf@macbook.be.48ers.dk>
	<085BE1E4-945F-4690-9DFC-627F242831A6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/3/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Oct 3, 2007, at 10:43 AM, Peter Korsgaard wrote:
>
> > According to booting-without-of.txt, fsl_spi mode should be either
> > "cpu" or "qe", not "cpu-qe".
> >
> > Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>
> I think we should update the doc instead of the code here. Thoughts?

Updating the doc is more backward compatible.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
