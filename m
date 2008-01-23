Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 772C1DDE2C
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 10:01:01 +1100 (EST)
To: Juergen Beisert <jbe@pengutronix.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [MPC5200] problem running FEC and ATA
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 23 Jan 2008 10:03:14 +0100."
	<200801231003.15045.jbe@pengutronix.de>
Date: Thu, 24 Jan 2008 00:01:00 +0100
Sender: wd@denx.de
Message-Id: <20080123230100.0CEE9247A1@gemini.denx.de>
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

In message <200801231003.15045.jbe@pengutronix.de> you wrote:
> 
> The one who needs this patch (CPU card vendor 1):
> 
> MPC5200CVR400B, M62C REV 1, QCW0723T
> 
> The CPUs who do not need this patch (CPU card vendor 2):
> 
> SPC5200CBV400B, M62C REV 1, QAG0610C
> MPC5200CVR400B, M62C REV 1, QAJ0613F

This is all Rev. B stuff, and the patch should be applied  to  all  of
them (actually the patch can always be applied - it will be activated
depending on the PVR reading).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is impractical for  the  standard  to  attempt  to  constrain  the
behavior  of code that does not obey the constraints of the standard.
                                                          - Doug Gwyn
