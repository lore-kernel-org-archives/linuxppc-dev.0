Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t46k43QPGzDvHl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 11:11:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: Cyril Bur <cyrilbur@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: process.c: fix Kconfig typo
In-Reply-To: <CAD3Xx4JO-BAtLkV3YpRL8rF6-k6qXv5Hx=eyBukN4nz=fnypow@mail.gmail.com>
References: <20161005055726.5614-1-valentinrothberg@gmail.com>
 <1475708074.735.2.camel@gmail.com> <878ttby7vh.fsf@concordia.ellerman.id.au>
 <CAD3Xx4KqNbpjognpyC=NVqFQ0wH+uc+vQU23PP99625ufCLZnA@mail.gmail.com>
 <87y41bwfyy.fsf@concordia.ellerman.id.au>
 <CAD3Xx4JO-BAtLkV3YpRL8rF6-k6qXv5Hx=eyBukN4nz=fnypow@mail.gmail.com>
Date: Thu, 27 Oct 2016 11:11:08 +1100
Message-ID: <87pommwt0j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Valentin Rothberg <valentinrothberg@gmail.com> writes:
> On Wed, Oct 26, 2016 at 12:40 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> diff --git a/scripts/checkkconfigsymbols.py b/scripts/checkkconfigsymbols.py
>> index a32e4da4c117..3820f00b066a 100755
>> --- a/scripts/checkkconfigsymbols.py
>> +++ b/scripts/checkkconfigsymbols.py
>> @@ -88,7 +88,7 @@ def parse_options():
>>      if args.commit and args.diff:
>>          sys.exit("Please specify only one option at once.")
>>
>> -    if args.diff and not re.match(r"^[\w\-\.]+\.\.[\w\-\.]+$", args.diff):
>> +    if args.diff and not re.match(r"^[\w\-\.\^]+\.\.[\w\-\.\^]+$", args.diff):
>>          sys.exit("Please specify valid input in the following format: "
>>                   "\'commit1..commit2\'")
>
> Looks great.  If you agree, I'll pick this up and send the patch to
> Greg (who takes patches for this script)?

That'd be great, thanks.

cheers
