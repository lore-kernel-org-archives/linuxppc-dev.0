Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2106FDE00E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 01:38:16 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: boot/wrap assumes a biarch toolchain?
References: <20071029140719.GA17120@kryten>
Date: Mon, 29 Oct 2007 15:38:09 +0100
In-Reply-To: <20071029140719.GA17120@kryten> (Anton Blanchard's message of
	"Mon\, 29 Oct 2007 09\:07\:20 -0500")
Message-ID: <jesl3udm0e.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, jdittmer@ppp0.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:

> One way to make this go away would be to build binutils as biarch:
>
> # configure --target=powerpc-linux --enable-targets=powerpc64-linux ...

If you configure your toolchain for powerpc64-linux you get a biarch
toolchain by default.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
