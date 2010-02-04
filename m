Return-Path: <pl@ninthfloor.org>
Received: from mail.ninthfloor.org (ninthfloor.org [109.74.194.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "nabla.ninthfloor.org",
	Issuer "nabla.ninthfloor.org" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ECC0AB7D42
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Feb 2010 00:48:40 +1100 (EST)
Received: from ninthfloor.org (ninthfloor.org [IPv6:2001:470:1f09:79c::1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested) (Authenticated sender: pl)
	by mail.ninthfloor.org (Postfix) with ESMTPSA id 54AA11C047
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Feb 2010 13:39:40 +0000 (UTC)
Date: Thu, 4 Feb 2010 13:39:35 +0000
From: Paride Legovini <pl@ninthfloor.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: resurrecting the mvme5100 ppc platform
Message-ID: <20100204133935.GA9337@ninthfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,
I'm just started working on some mvme5100 boards, and so I discovered
that support for these cards has been dropped with linux-2.6.27 due to
lack of interest. Here is the relevent post on linuxppc-embedded:

http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg30049.html

Well, I'd really like to see support for the mvme5100 to be reintegrated
in the kernel. I'm willing to help on this, but at the moment I don't
know how much work is to be done, as I don't know how the switch from
ppc to powerpc changed things.
If anybody of you is interested please drop me an email.

Thank you,
Paride
