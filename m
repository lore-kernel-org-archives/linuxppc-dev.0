Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8199EB7D79
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 02:23:59 +1100 (EST)
In-Reply-To: <20100226195018.GA26867@loki.buserror.net>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<20100226195018.GA26867@loki.buserror.net>
Subject: Re: [PATCH 1/4] 8xx: Optimze TLB Miss handlers
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFB2EA86C9.2E362C10-ONC12576D7.00542469-C12576D7.00549115@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 27 Feb 2010 16:23:41 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Scott Wood <scottwood@freescale.com> wrote on 2010/02/26 20:50:18:
>
> On Fri, Feb 26, 2010 at 09:29:40AM +0100, Joakim Tjernlund wrote:
> > This removes a couple of insn's from the TLB Miss
> > handlers whithout changing functionality.
> > ---
>
> Did a quick test of the patchset, seems to work OK (without CONFIG_SWAP or
> CONFIG_MODULES).  Didn't try with CONFIG_8xx_CPU6.

Cool, thanks a lot!

Not sure anyone is using 2.6 with CPU6 errata. Seems it was fixed years ago.

Should I resend the whole series with SOB line or just include it here?

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
