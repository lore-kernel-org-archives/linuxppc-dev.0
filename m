Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id E4939B7BDC
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Sep 2009 17:34:36 +1000 (EST)
Date: Mon, 28 Sep 2009 09:34:34 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] i2c-mpc: Do not generate STOP after read.
Message-ID: <20090928093434.57157435@hyperion.delvare>
In-Reply-To: <OFC822309E.F9FB4F3C-ONC125763F.0029159C-C125763F.00293F85@transmode.se>
References: <1253620242-18461-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<4ABC94ED.6070508@grandegger.com>
	<OFDA26E787.32612566-ONC125763E.007AD2FD-C125763E.007B4FFC@transmode.se>
	<20090928092809.7272b6e6@hyperion.delvare>
	<OFC822309E.F9FB4F3C-ONC125763F.0029159C-C125763F.00293F85@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Esben Haabendal <eha@doredevelopment.dk>,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 28 Sep 2009 09:30:32 +0200, Joakim Tjernlund wrote:
> Jean Delvare <khali@linux-fr.org> wrote on 28/09/2009 09:28:09:
> >
> > On Mon, 28 Sep 2009 00:26:54 +0200, Joakim Tjernlund wrote:
> > > Jean, I just noticed you pull request for i2c on LKML but I didn't see this
> > > patch nor have I got any feedback from you. What is your view?
> >
> > My view is that i2c-mpc is nor under my jurisdiction, so I did not, and
> > will not, pay any attention to it.
> 
> Ah, that explains it. Who then will look after i2c-mpc? Kumar?

What does MAINTAINERS say?

-- 
Jean Delvare
