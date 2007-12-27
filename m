Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C3C4DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 21:17:49 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2] powerpc: Do not fail build if mkimage is not available
References: <20071227101404.2C05F2405E@gemini.denx.de>
Date: Thu, 27 Dec 2007 11:17:42 +0100
In-Reply-To: <20071227101404.2C05F2405E@gemini.denx.de> (Wolfgang Denk's
	message of "Thu\, 27 Dec 2007 11\:14\:04 +0100")
Message-ID: <jetzm4jvax.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, paulus@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk <wd@denx.de> writes:

> In message <200712261708.51432.mb@bu3sch.de> you wrote:
>> On Wednesday 26 December 2007 17:03:43 Andreas Schwab wrote:
>> > Michael Buesch <mb@bu3sch.de> writes:
>> > 
>> > > +    set +e
>> > >      mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
>> > >  	$uboot_version -d "$vmz" "$ofile"
>> > > +    [ $? -eq 0 ] || exit 0
>> > > +    set -e
>> > 
>> > mkimage ... || exit 0
>> 
>> Could you PLEASE increase your verbosity?
>> Why is mkimage || exit 0 any better than my test?
>
> Because it works, while your's doesn't.
>
> Make runs each command in a new shell.

This is a shell script, not a makefile.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
