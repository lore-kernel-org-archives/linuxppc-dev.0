Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2741FDDF4B
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 17:50:06 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
	<1215411800.8970.91.camel@pasglop>
	<20080707063522.5FE55154246@magilla.localdomain>
Date: Mon, 07 Jul 2008 09:49:57 +0200
In-Reply-To: <20080707063522.5FE55154246@magilla.localdomain> (Roland
	McGrath's message of "Sun, 6 Jul 2008 23:35:22 -0700 (PDT)")
Message-ID: <je8wwet9p6.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath <roland@redhat.com> writes:

>> I'm not sure... if ld.conf.d isn't parse of the kernel source tree then
>> it -will- end in tears...
>
> Of course, you should include the file you want people to install
> as part of the kernel source or build.  You can copy it into
> place in make install or something if you like (convention is to
> call it something.conf in /etc/ld.so.conf.d); then run ldconfig.

That will make it part of the kernel ABI, since the mapping depends on
the running kernel, doesn't it?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
