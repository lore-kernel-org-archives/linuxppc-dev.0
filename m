Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C9B8DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 03:38:21 +1100 (EST)
In-Reply-To: <49CCD3E8.9040007@freescale.com>
References: <1238089445-28396-1-git-send-email-Joakim.Tjernlund@transmode.se>	<2a27d3730903270245k6e8633eehfb5cd3fcebd36240@mail.gmail.com>
	<OFDCE90357.0EDC5DC1-ONC1257586.003759A3-C1257586.00390AD3@transmode.se>
	<49CCD3E8.9040007@freescale.com>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [PATCH] ucc_geth: Rework the TX logic.
Message-ID: <OFEFCEAFB5.CC21FFBB-ONC1257589.005AEF16-C1257589.005B64EB@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Mon, 30 Mar 2009 18:38:16 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, pku.leo@gmail.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 27/03/2009 14:26:00:
> 
> Joakim Tjernlund wrote:
> > This is a bit better than the current type casts. Moving over to qe_bd
> > accesses is a bigger cleanup that will have to be a seperate patch.
> > I am not sure it is an all win as you probably loose the ability
> > to read both status and len in one access.
> 
> Not if you define the struct to have one status_len field (or a union of 

> that with separate fields), as gianfar does.

gianfar does not seem to use in_/out_ functions for the BDs. Works just
fine that too it seems. I always felt that the in_/out_ functions
was extra baggage that the Freescale CPUs don't need. There is
something in between that is missing.

 Jocke
