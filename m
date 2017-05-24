Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeremy Kerr <jk@ozlabs.org>, Sombat Tragolgosol <sombat3960@gmail.com>,
 Linuxppc-dev@lists.ozlabs.org
Cc: geoff@infradead.org
Subject: Re: SPU not working for kernel 4.9, 4.10, 4.11a and 4.12
In-Reply-To: <32cc4462-0a47-ee5a-7429-af5428126743@ozlabs.org>
References: <CAC1vu621cqMcucgMGF9AvW2VVBFDNbqbW2ZPkuFRRHWjO58CFQ@mail.gmail.com>
 <c16c0ba8-aa6d-0dbd-28d2-d73fda643ae5@ozlabs.org>
 <32cc4462-0a47-ee5a-7429-af5428126743@ozlabs.org>
Date: Wed, 24 May 2017 10:58:35 +1000
Message-ID: <871srfax50.fsf@concordia.ellerman.id.au>
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

Jeremy Kerr <jk@ozlabs.org> writes:

> Hi all,
>
>
>> Looks like this also happens with the simple spu_run test:
>> 
>>  https://github.com/jk-ozlabs/spufs-testsuite/blob/master/tests/03-spu_run/01-spu_run.c
>> 
>> ... might need some debugging here, I'll update if I find anything.
>
> And it appears we're stuck in the POLL_WHILE_FALSE() loop in
> wait_tag_complete() called from restore_lscsa().
>
> Because spufs itself has been fairly static, I suspect some other change
> has meant that MFC DMAs aren't working; so at this point, a bisect might
> be the best way forward. Do you see the exact same behaviour on 4.9 (but
> 4.8 works?)

I can bisect it here, I have everything setup to autoboot etc.

cheers
