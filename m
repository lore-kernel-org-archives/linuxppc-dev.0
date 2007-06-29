Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7063EDDFF8
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 01:22:56 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull from 'for_paulus' branch
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
Date: Fri, 29 Jun 2007 17:22:36 +0200
In-Reply-To: <18052.42546.78964.805791@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Fri\, 29 Jun 2007 16\:26\:58 +1000")
Message-ID: <jelke2ss3n.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> It turns out that with Arnd's patches we now get "-mcpu=powerpc64" on
> the command line, and that means that gcc *doesn't* put "-mppc64" the
> as command line, and as barfs on the 64-bit instructions.

The assembler should be called with -a64, which has the effect of
defaulting to -mppc64.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
