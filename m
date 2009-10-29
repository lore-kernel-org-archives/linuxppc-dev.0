Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5DD81B7B70
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 17:26:55 +1100 (EST)
To: Wolfram Sang <w.sang@pengutronix.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: SPRN_SVR for MPC5121e?
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20091028152324.GC3920@pengutronix.de>
References: <20091028152324.GC3920@pengutronix.de>
Date: Thu, 29 Oct 2009 07:26:50 +0100
Message-Id: <20091029062650.79D42E916D8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Wolfram Sang,

In message <20091028152324.GC3920@pengutronix.de> you wrote:
> 
> my MPC5121e (Rev2) has PVR/SVR: 0x8086_2010/0x8018_0020 (as mentioned in the manual)
...
> Does someone here have a Rev1 and can ultimately confirm and/or supply the
> complete PVR/SVR for Rev1? Couldn't find any hint neither in the manual nor in
> the web.

We saw

	PVR/SVR = 0x80862010 / 0x80180010 for MPC5121
and

	PVR/SVR = 0x80862010 / 0x80180030 for MPC5123

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Quantum particles: The dreams that stuff is made of.
