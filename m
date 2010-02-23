Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1546B7CEC
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 17:59:42 +1100 (EST)
In-Reply-To: <14321.1266890296@neuling.org>
References: <OF21CCB5A6.CDFDB6C1-ONC12576D2.00430B25-C12576D2.0043C4BB@transmode.se>
	<14321.1266890296@neuling.org>
Subject: Re: default stack size for threads changed
To: Michael Neuling <mikey@neuling.org>
Message-ID: <OF4294A585.FC2D1ECA-ONC12576D3.00254DF9-C12576D3.002629BA@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 23 Feb 2010 07:56:50 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> wrote on 2010/02/23 02:58:16:
>
> In message <OF21CCB5A6.CDFDB6C1-ONC12576D2.00430B25-C12576D2.
> 0043C4BB@transmode.se> you wrote:
> >
> > With current, 2.6.33-rc6, linux the default stack size changed from unlimited
> > to 8MB:
> > # > ulimit -s
> > 8192
> >
> > This makes NPTL allocate a 8MB stack for each thread that is created.
> > This breaks in our embedded system. Although this
> > can be fixed in our app I wonder if this is intentional?
>
> When did this change from unlimited?

Sometime after 2.6.30 since that was the previous kernel we used, but I see
now that I read the wrong line. The stack size was 8MB in 2.6.30 too so
something else caused the high stack usage.

>
> It's unlikely but this might be related
> 803bf5ec259941936262d10ecc84511b76a20921 (post rc7).  You'll also need
> to grab this http://patchwork.kernel.org/patch/79365/.

I see, will try. Hope fully I will see an improvement. Thanks.

>
> Mikey
>
> >
> >  Jocke
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
>
>
