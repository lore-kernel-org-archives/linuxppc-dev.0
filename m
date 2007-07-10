Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8942BDDF2E
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 19:46:42 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Infinite loop/always true check possible with unsigned
	counter.
References: <469270F3.4070206@austin.ibm.com> <46928691.2040008@austin.ibm.com>
	<18066.53384.449544.952545@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jul 2007 11:46:28 +0200
In-Reply-To: <18066.53384.449544.952545@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Tue\, 10 Jul 2007 10\:19\:20 +1000")
Message-ID: <je1wfgh9qj.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> Manish Ahuja writes:
>
>> Repost to fix my email id.
>> 
>> Fix to correct a possible infinite loop or an always true check when the 
>> unsigned long counter "i" is used in
>> lmb_add_region() in the following for loop:
>> 
>> for (i = rgn->cnt-1; i >= 0; i--)
>
> Unfortunately this won't fix the bug.  Since rgn->cnt is unsigned
> long, the comparison will be done as an unsigned comparison even if i
> is signed.

??? There is no rgn->cnt involved in the comparison.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
