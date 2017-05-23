Return-Path: <jk@ozlabs.org>
Subject: Re: SPU not working for kernel 4.9, 4.10, 4.11a and 4.12
To: Sombat Tragolgosol <sombat3960@gmail.com>, Linuxppc-dev@lists.ozlabs.org
Cc: geoff@infradead.org
References: <CAC1vu621cqMcucgMGF9AvW2VVBFDNbqbW2ZPkuFRRHWjO58CFQ@mail.gmail.com>
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <c16c0ba8-aa6d-0dbd-28d2-d73fda643ae5@ozlabs.org>
Date: Tue, 23 May 2017 15:21:36 +1000
MIME-Version: 1.0
In-Reply-To: <CAC1vu621cqMcucgMGF9AvW2VVBFDNbqbW2ZPkuFRRHWjO58CFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

> I'd like to report that SPU not working for kernel > 4.9. The problem
> caused by spe_context_run function, when call , it never return back.

Looks like this also happens with the simple spu_run test:

 https://github.com/jk-ozlabs/spufs-testsuite/blob/master/tests/03-spu_run/01-spu_run.c

... might need some debugging here, I'll update if I find anything.

Cheers,


Jeremy
