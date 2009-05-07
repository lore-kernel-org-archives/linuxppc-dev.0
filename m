Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 8802ADDF87
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 19:19:53 +1000 (EST)
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <OF97606123.49B50465-ONC12575AF.002E2518-C12575AF.002E6300@transmode.se>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<OF97606123.49B50465-ONC12575AF.002E2518-C12575AF.002E6300@transmode.se>
Date: Thu, 07 May 2009 11:19:48 +0200
Message-Id: <20090507091948.6C86883420E8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Joakim Tjernlund,

In message <OF97606123.49B50465-ONC12575AF.002E2518-C12575AF.002E6300@transmode.se> you wrote:
>
> Just a stab in the dark: Perhaps the fec->fecp->fec_mii_speed field is
> misaligned or is 16 bits ?

Good idea. The RM documents the register at offset 0x44 and describes
it as 32 bits... and it's working fine on the MPC5121ADS  board,  but
fails on ARIA.

Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Lots of people drink from the wrong bottle sometimes.
	-- Edith Keeler, "The City on the Edge of Forever",
	   stardate unknown
