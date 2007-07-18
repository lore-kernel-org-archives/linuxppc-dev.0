Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB923DDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:13:03 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/2] fix showing xmon help
References: <20070718.182640.-1300542340.kouish@swc.toshiba.co.jp>
	<7bd7b12c7bd2303039a850a1fee9634c@bga.com>
Date: Wed, 18 Jul 2007 18:12:58 +0200
In-Reply-To: <7bd7b12c7bd2303039a850a1fee9634c@bga.com> (Milton Miller's
	message of "Wed\, 18 Jul 2007 10\:51\:50 -0500")
Message-ID: <je1wf5bshh.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller <miltonm@bga.com> writes:

>>                 case '?':
>> -                       printf(help_string);
>> +                       xmon_puts(help_string);
>>                         break;
>>
>
> nonstdio.h #defines printf to xmon_printf.  Please add a similar line 
> for puts, and use the define here.  (It will avoid an unnecessary 
> difference with the user space version).

User space puts add a newline, which this xmon_puts doesn't.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
