Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szVYC3g1YzDt2W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 22:47:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 2/3] powerpc/pseries: Define & use a type for the
 plpar_hcall() retvals
In-Reply-To: <b922cd6c-a44d-6950-93d7-6645fd1f7fac@gmail.com>
References: <1476780032-21643-1-git-send-email-mpe@ellerman.id.au>
 <1476780032-21643-2-git-send-email-mpe@ellerman.id.au>
 <b922cd6c-a44d-6950-93d7-6645fd1f7fac@gmail.com>
Date: Wed, 19 Oct 2016 22:47:26 +1100
Message-ID: <87lgxk4l2p.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On 18/10/16 19:40, Michael Ellerman wrote:
>> We have now had two nasty stack corruption bugs caused by incorrect
>> sizing of the return buffer for plpar_hcall()/plpar_hcall9().
>> 
>> To avoid any more such bugs, define a type which encodes the size of the
>> return buffer, and change the argument of plpar_hcall() to be of that
>> type, meaning the compiler will check for us that we passed the right
>> size buffer.
>> 
>> There isn't an easy way to do this incrementally, without introducing a
>> new function name, eg. plpar_hcall_with_struct(), which is ugly as hell.
>> So just do it in one tree-wide change.
>> 
> Conceptually looks god, but I think we need to abstract the return values
> as well. I'll test and see if I can send you something on top of this

Not sure I know what you mean.

cheers
