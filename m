Return-Path: <mware@elphinstone.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4EB4AB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 10:02:11 +1000 (EST)
Received: from ipmail01.adl6.internode.on.net (ipmail01.adl6.internode.on.net
	[203.16.214.146]) by ozlabs.org (Postfix) with ESMTP id 0A37BDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 10:02:09 +1000 (EST)
MIME-Version: 1.0
Message-ID: <16811.1248307327@internode.on.net>
To: <davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 23 Jul 2009 09:02:07 +0900
Subject: Re: [PATCH v3] net: Rework mdio-ofgpio driver to use
	of_mdioinfrastructure
From: Mark Ware <mware@elphinstone.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: mware@elphinstone.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 On Thu 23/07/09  2:10 AM , David Miller davem@davemloft.net sent:
> Your email client has massively corrupted this patch, I even tried
> to fix it up but it's so bad that I just gave up half-way through.
>=20
> Please use an attachment or whatever is necessary to get this
> patch submitted cleanly and without it getting damaged.  Read:
>=20
> linux/Documentation/email-clients.txt for tips.
>=20
> Thanks.

Sorry for the waste of time.  I've obviously somehow broken my thunderbird =
config.

Patch is attached, hopefully with correct MIME type - this webmail client i=
s worse than Outlook.

(Incidently, I was able to apply the corrupted patch after the following tw=
o substitutions: s/^  / / and s/^$/ /)

Regards,
Mark
