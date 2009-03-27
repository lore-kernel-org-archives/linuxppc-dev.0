Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68301DDE11
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 00:26:06 +1100 (EST)
Message-ID: <49CCD3E8.9040007@freescale.com>
Date: Fri, 27 Mar 2009 08:26:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] ucc_geth: Rework the TX logic.
References: <1238089445-28396-1-git-send-email-Joakim.Tjernlund@transmode.se>	<2a27d3730903270245k6e8633eehfb5cd3fcebd36240@mail.gmail.com>
	<OFDCE90357.0EDC5DC1-ONC1257586.003759A3-C1257586.00390AD3@transmode.se>
In-Reply-To: <OFDCE90357.0EDC5DC1-ONC1257586.003759A3-C1257586.00390AD3@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Joakim Tjernlund wrote:
> This is a bit better than the current type casts. Moving over to qe_bd
> accesses is a bigger cleanup that will have to be a seperate patch.
> I am not sure it is an all win as you probably loose the ability
> to read both status and len in one access.

Not if you define the struct to have one status_len field (or a union of 
that with separate fields), as gianfar does.

-Scott
