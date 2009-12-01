Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35E261007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 18:57:51 +1100 (EST)
Subject: Re: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of
	ata_bmdma_stop()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tejun Heo <tj@kernel.org>
In-Reply-To: <4B14C6D7.3030303@kernel.org>
References: <20091201070833.CC084B7BD9@ozlabs.org>
	<4B14C4DC.6060107@kernel.org> <1259652545.2076.321.camel@pasglop>
	<4B14C6D7.3030303@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Dec 2009 18:57:01 +1100
Message-ID: <1259654221.2076.325.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-01 at 16:33 +0900, Tejun Heo wrote:
> > Feel free to pick that one up earlier if you want (ie for 2.6.32),
> as
> > long as we manage to get it in in 2.6.33 -before- I push
> powerpc-next to
> > Linus, I'm happy :-) (or we can have it in both trees).
> 
> As nasty as the bug might be, given that we haven't had too much
> problem with that, I think it would be best to give it some time to be
> tested before releasing it to users.  It causes behavior differences
> for all bmdma drivers which implement custom bmdma_stop.  It's an
> apparent bug fix but well the nasty ones are always apparent bug
> fixes, right?  :-) 

Yeah, I agree. I wouldn't be comfortable pushing it into .32 to be
honest after a quick grep of how many drivers actually use that hook and
considering that no problem was reported so far...

I'll merge it with the rest of the powerpc stuff during the .33 merge
window if you are ok with that.

Cheers,
Ben.
