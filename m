Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1649DDDF87
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 19:30:19 +1000 (EST)
In-Reply-To: <20090507091948.6C86883420E8@gemini.denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<OF97606123.49B50465-ONC12575AF.002E2518-C12575AF.002E6300@transmode.se>
	<20090507091948.6C86883420E8@gemini.denx.de>
To: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
Message-ID: <OF94736CCE.32812BF1-ONC12575AF.0033EF92-C12575AF.003433E8@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 7 May 2009 11:30:11 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk <wd@denx.de> wrote on 07/05/2009 11:19:48:
> 
> Dear Joakim Tjernlund,
> 
> In message 
<OF97606123.49B50465-ONC12575AF.002E2518-C12575AF.002E6300@transmode.se> 
you wrote:
> >
> > Just a stab in the dark: Perhaps the fec->fecp->fec_mii_speed field is
> > misaligned or is 16 bits ?
> 
> Good idea. The RM documents the register at offset 0x44 and describes
> it as 32 bits... and it's working fine on the MPC5121ADS  board,  but
> fails on ARIA.

OK, this is just a guess too: Some odd byte order requirements?
No more ideas, sorry.

 Jocke
