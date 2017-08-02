Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMc1p483bzDrn8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 12:04:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Matt Brown <matthew.brown.dev@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v5 2/2] raid6/altivec: Add vpermxor implementation for raid6 Q
 syndrome
In-Reply-To: <878tj2sxix.fsf@linkitivity.dja.id.au>
References: <20170428055809.2675-1-matthew.brown.dev@gmail.com>
 <20170428055809.2675-2-matthew.brown.dev@gmail.com>
 <878tj2sxix.fsf@linkitivity.dja.id.au>
Date: Wed, 02 Aug 2017 12:04:14 +1000
Message-ID: <87d18esp29.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:

> Hi Matt,
>
>> The raid6 Q syndrome check has been optimised using the vpermxor
>> instruction.
>
> Very much a nit, but normally we'd write the change that the patch makes
> as a command: "Optimise the raid6 Q syndrome generation using the
> vpermxor instruction" - see
> https://www.kernel.org/doc/html/v4.11/process/submitting-patches.html#describe-your-changes

There's a good list here:
  https://chris.beams.io/posts/git-commit/

Which includes "Use the imperative mood in the subject line".

And has a good rule of thumb:

  A properly formed Git commit subject line should always be able to
  complete the following sentence:
  
  If applied, this commit will [your subject line here]


In this case Matt's subject is fine, but IMHO you should also use the
imperative mood for the body of the change log - which is basically what
you said :)

cheers
