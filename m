Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E369F1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 12:58:40 +1100 (AEDT)
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E848E1401E7
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2015 12:58:38 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id 68so40231949pfc.1
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 17:58:38 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, Russell Currey <ruscur@russell.cc>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: add va_end()
In-Reply-To: <1450355077.8262.0.camel@ellerman.id.au>
References: <1450341660-31305-1-git-send-email-dja@axtens.net>
 <1450354171.1669.4.camel@russell.cc> <1450355077.8262.0.camel@ellerman.id.au>
Date: Fri, 18 Dec 2015 12:58:30 +1100
Message-ID: <87bn9o34c9.fsf@gamma.ozlabs.ibm.com>
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


Hi all,

Yes, sorry, that was a bit lax of me.
Michael, your title sounds good.
Thanks!

Regards,
Daniel


> On Thu, 2015-12-17 at 23:09 +1100, Russell Currey wrote:
>> On Thu, 2015-12-17 at 19:41 +1100, Daniel Axtens wrote:
>> > cppcheck picked up that there were a couple of missing va_end()
>> > calls in functions using va_start().
>> > 
>> > Signed-off-by: Daniel Axtens <dja@axtens.net>
>> Hey Daniel,
>> 
>> It's probably not worth a V2 but I think this could use a commit title that's a
>> bit more detailed.  Right now it doesn't really allude to what it fixes or what
>> it affects.
>
> Yeah, the change log is OK, but the actual subject is a bit terse.
>
> I changed it to "powerpc: Add missing calls to va_end()".
>
> cheers
