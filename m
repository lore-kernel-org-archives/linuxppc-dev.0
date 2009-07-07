Return-Path: <schwab@linux-m68k.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B3AE1B7086
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 22:40:40 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 273ABDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jul 2009 22:40:38 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Inline assembly queries [2]
References: <abe8a1fd0907022344k2eb9874ejdbda3209a7cadf40@mail.gmail.com>
	<20090703174031.GA12410@cynthia.pants.nu> <m23a9deb87.fsf@igel.home>
	<20090706065627.GA12499@iram.es>
Date: Tue, 07 Jul 2009 14:40:02 +0200
In-Reply-To: <20090706065627.GA12499@iram.es> (Gabriel Paubert's message of
	"Mon, 6 Jul 2009 08:56:27 +0200")
Message-ID: <m37hykis4d.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gcc-help@gcc.gnu.org, kernel mailz <kernelmailz@googlemail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gabriel Paubert <paubert@iram.es> writes:

> On Fri, Jul 03, 2009 at 10:57:12PM +0200, Andreas Schwab wrote:
>> The 'Z' constraint is required for a memory operand for insns that don't
>> have an update form (which would be selected by the %U modifier).  
>
> Hmmm, I believed that it was for instructions that only have an indexed
> form (all Altivec, byte reverse, and l?arx/st?cx for atomic operations).
>
> Of course none of these instructions have an update form, but they don't
> have an offset encoded in the instruction either.

Yes, you are right.  IIRC there are either all u/x/ux forms or only the
x form.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
