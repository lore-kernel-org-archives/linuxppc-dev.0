Return-Path: <Stefan.Nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id B77B067A6F
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 01:56:36 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859335@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859335@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 17:56:33 +0200
Message-Id: <1112716593.12785.29.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-04-05 at 10:37 -0500, Rune Torgersen wrote:
> I've been running into the old problem of the kernel ip stack crasheing
> the kernel, because of early packets again.
> 
> This has been mentioned on this list several times before, but the
> worarounds that used to work doesn't seem to work anymore.
> (like changing the order of things in ip_init())
> 
> As far as I can tell, it is because the FCC enet drivers starts to
> receive packets way before the ip stack is initialized.
> 
> Does anybody have any good ideas on how to fix this?

Maybe you want to try my version:

http://ozlabs.org/ppc32-patches/patch.pl?id=14

Or is it equal to your (no longer working) solution?

-- 
Stefan Nickl
Kontron Modular Computers
