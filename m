Message-ID: <3CE2C88D.6010908@embeddededge.com>
Date: Wed, 15 May 2002 16:43:57 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH 2.5] More i8259 cleanups
References: <20020515171104.GQ721@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> Hey all.  I've been doing more OpenPIC/i8259 work and here's the next
> patch I'll be pushing to linuxppc-2.5 soon.

Looks good.....just one little thing, how about we wrap some more of these
functions with __init attributes?  There are a bunch of these couple of
line functions, like openpic_enable_sie(), that are only called from the
init function.  That's one of the reasons I originally surrounded them
by ifdefs......probably doesn't amount to much, but it is at least logically
consistent since the function(s) that call them are also __init's :-)

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
