Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7758D67B94
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2006 09:08:25 +1000 (EST)
Date: Sun, 17 Sep 2006 09:08:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 3/7] POWERPC: Move generic cpm2 stuff to powerpc
Message-Id: <20060917090835.b1351a70.sfr@canb.auug.org.au>
In-Reply-To: <FF0EF221-284E-4E0A-8576-EFC7E1CE0DE4@embeddedalley.com>
References: <20060915213751.128e85f3@localhost.localdomain>
	<20060915173912.7984.40164.stgit@localhost.localdomain>
	<20060916183607.94d6facc.sfr@canb.auug.org.au>
	<FF0EF221-284E-4E0A-8576-EFC7E1CE0DE4@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 16 Sep 2006 12:09:34 -0400 Dan Malek <dan@embeddedalley.com> wrote:
>
> 
> On Sep 16, 2006, at 4:36 AM, Stephen Rothwell wrote:
> 
> >
> >> +	if (brg < 4) {
> >> +		bp = (uint *)&cpm2_immr->im_brgc1;
> >> +	}
> >> +	else {
> >
> > Normally:
> > 	if (brg < 4)
> > 		bp = (uint *)&cpm2_immr->im_brgc1;
> > 	else {
> 
> Sorry, I'm going to nit-pick right back.  This isn't
> "normal", it's just your preference.  :-)
> 
> When the "else" part contains braces, the "if"
> part should as well.  If this get modified and
> nested some day in the future, this can cause
> a very subtle coding error.

Not if you are consistent (and many aren't, I agree).

I was more commenting on the

	}
	else {

bit wich should (at worst) be 

	} else {

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
