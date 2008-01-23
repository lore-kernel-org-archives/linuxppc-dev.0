Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 129DFDDDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 11:20:42 +1100 (EST)
To: Juergen Beisert <jbe@pengutronix.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [MPC5200] problem running FEC and ATA
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 21 Jan 2008 17:28:22 +0100."
	<200801211728.22817.jbe@pengutronix.de>
Date: Wed, 23 Jan 2008 01:20:40 +0100
Sender: wd@denx.de
Message-Id: <20080123002040.5049F24781@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, "Mehlan,
	Markus \(Ritter Elektronik\)" <markus.mehlan@ritter-elektronik.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <200801211728.22817.jbe@pengutronix.de> you wrote:
>
> Is anybody out there with more MPC5200B experience? Can someone tell me why
> some MPC5200B are need this patch and others not? We have two different
> systems here (cards from different vendors) with the same processor, one
> needs this BSDIS-patch and the other not. ???????????????

Is it really exactly the same CPU revision? My guess is that one is
rev. B and the other one is older...

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It would be illogical to assume that all conditions remain stable
	-- Spock, "The Enterprise" Incident", stardate 5027.3
