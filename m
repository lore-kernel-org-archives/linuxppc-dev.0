Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D9E4B7B66
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 20:28:12 +1100 (EST)
In-Reply-To: <1260348995.16132.37.camel@pasglop>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1258712471-3104-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1258712471-3104-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1258712471-3104-5-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1260332399.16132.7.camel@pasglop>
	<OFB03B60EA.0352DA78-ONC1257687.002955A6-C1257687.002A145F@transmode.se>
	<1260348995.16132.37.camel@pasglop>
Subject: Re: [PATCH 04/10] 8xx: Always pin kernel instruction TLB
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF08658DD6.A5DC99F1-ONC1257687.00334561-C1257687.0033AE30@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 9 Dec 2009 10:24:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 09/12/2009 09:56:35:
>
> On Wed, 2009-12-09 at 08:39 +0100, Joakim Tjernlund wrote:
> > The later isn't as simple :) I believe the bulk of such code in
> > entry_32.S.
>
> Yeah but it would be useful for hash I suppose if one really wants to
> boot with nobats. Though at least on hash most of the time we have ways
> to recover by mean of MSR:RI being cleared, which your TLB miss code
> doesn't check...

Never looked at this so I cannot comment.

>
> > Anyhow, the config option is still valid as if enabled
> > it will pin several DTLB's too. Scott had some concerns about removing
> > the config option completely so this was the next best thing.
>
> Well, if you want to pin at least one entry, then just remove the #if
> completely but don't leave a #if 1 :-)

I could, but I wanted to have an easy way back to the old way if
the need arises.
Anyway, I am rather busy ATM with more pressing matters so I would
appreciate if you could take the patch as is.

 Jocke
