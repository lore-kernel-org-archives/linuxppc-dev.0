Date: Tue, 7 Aug 2001 14:04:10 -0700
From: Matt Porter <mporter@mvista.com>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: How about a few symlinks.....
Message-ID: <20010807140410.A19530@cx258813-a.chnd1.az.home.com>
References: <3B7056AA.EAE5CEE1@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B7056AA.EAE5CEE1@mvista.com>; from dan@mvista.com on Tue, Aug 07, 2001 at 04:59:22PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 07, 2001 at 04:59:22PM -0400, Dan Malek wrote:
>
> While editing some Makefiles I was wondering what people thought
> of using symlinks to processor dependent files instead of nested
> ifdefs in Makefiles?
>
> For starters, make arch/ppc/kernel/head.S a symlink to the appropriate
> one in that directory, and derive the name to use from one of the
> config options.  I thought I would ask before demonstrating the change.

I like the general concept.  I was suggesting the general idea for header
files to Tom Rini recently since I really like how clean it makes things
in include/asm-arm where there are include/asm-arm/arch-???? directories.
Although their overall software architecture is different and we'd need
some changes, I think it's a great cleanup goal.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
