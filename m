Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 4267BB6F6F
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 20:57:42 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: kevin diggs <diggskevin38@gmail.com>
Subject: Re: cpu idle time going backward
References: <m2fwgvnwlm.fsf@igel.home>
 <CAKTLLVTHHSDTxybfJn3r0JOeRGtxgzJyCwAFf8w8gDxqbuXbyA__24208.5847691216$1323374038$gmane$org@mail.gmail.com>
Date: Fri, 09 Dec 2011 10:52:21 +0100
In-Reply-To: <CAKTLLVTHHSDTxybfJn3r0JOeRGtxgzJyCwAFf8w8gDxqbuXbyA__24208.5847691216$1323374038$gmane$org@mail.gmail.com>
 (kevin diggs's message of "Thu, 8 Dec 2011 13:53:24 -0600")
Message-ID: <m2liqmkr6y.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kevin diggs <diggskevin38@gmail.com> writes:

> On 12/8/11, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> There seems to be something wrong with cpu idle time accounting at least
>> on G5.  The value as reported in the cpu lines in /proc/stat seems to be
>> stuck in the interval [100000,210000] for each cpu, jumping back at
>> random points.  Any idea what could be the problem?
>>
>> Andreas.
>>
>> --
> What kernel versions?

It started with 3.2-rc1.  Will try to bisect.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
