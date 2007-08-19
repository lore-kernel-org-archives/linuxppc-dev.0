Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C2C1DDE21
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2007 22:09:45 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.23-rc3 broken on G5
References: <jelkccftt6.fsf@sykes.suse.de>
	<18116.52843.212978.281399@cargo.ozlabs.ibm.com>
	<jefy2j6qtq.fsf@sykes.suse.de>
	<18118.41979.148016.177427@cargo.ozlabs.ibm.com>
	<jey7g9i3qk.fsf@sykes.suse.de>
	<18119.42120.893384.555002@cargo.ozlabs.ibm.com>
Date: Sun, 19 Aug 2007 14:09:36 +0200
In-Reply-To: <18119.42120.893384.555002@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Sun\, 19 Aug 2007 12\:01\:44 +1000")
Message-ID: <jetzqvk9of.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> Andreas Schwab writes:
>
>> 1.25 GB.  It also has an nvidia gfx card, in case it matters.
>
> Could you try this patch and see if it fixes it?  It puts the code
> back to being a bit closer to what it was before.

That didn't change anything visibly.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
