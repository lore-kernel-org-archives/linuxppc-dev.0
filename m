Date: Wed, 15 May 2002 14:36:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH 2.5] More i8259 cleanups
Message-ID: <20020515213653.GA20456@opus.bloom.county>
References: <20020515171104.GQ721@opus.bloom.county> <3CE2C88D.6010908@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CE2C88D.6010908@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 15, 2002 at 04:43:57PM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> >Hey all.  I've been doing more OpenPIC/i8259 work and here's the next
> >patch I'll be pushing to linuxppc-2.5 soon.
>
> Looks good.....just one little thing, how about we wrap some more of these
> functions with __init attributes?

It's on my todo list.  I'll probably do it in 2.4 first as well,
soonish.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
