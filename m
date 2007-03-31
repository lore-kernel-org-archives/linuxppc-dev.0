Return-Path: <SRS0+ab4c384dcbfc503e0951+1315+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A148FDDE04
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Mar 2007 23:22:06 +1000 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: David Woodhouse <dwmw2@infradead.org>
To: Raquel Velasco and Bill Buck <bbrv@genesi-usa.com>
In-Reply-To: <BD8A1731-47B2-46CC-AB60-DF97448CF351@genesi-usa.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
	<1167773388.22068.443.camel@pmac.infradead.org>
	<1167773863.6165.82.camel@localhost.localdomain>
	<1167775493.3660.23.camel@shinybook.infradead.org>
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
	<45A0610E.60307@246tNt.com>
	<44901FD6-0F07-453A-934A-FF95EA1B8906@genesi-usa.com>
	<1175346945.3122.245.camel@pmac.infradead.org>
	<BD8A1731-47B2-46CC-AB60-DF97448CF351@genesi-usa.com>
Content-Type: text/plain
Date: Sat, 31 Mar 2007 14:21:59 +0100
Message-Id: <1175347319.3122.253.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Sylvain Munaut <tnt@246tNt.com>, Paul Mackerras <paulus@samba.org>,
	Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-03-31 at 08:18 -0500, Raquel Velasco and Bill Buck wrote:
> April...

OK, that should work for us. I've dusted off my Efika and made sure the
Fedora kernel is in reasonable shape for it, but we really do need the
partition handling sorted before it's going to be installable by normal
people. Please let me know as soon as you've got a prerelease which I
can try out.

-- 
dwmw2
