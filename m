Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3C2B376F.9070508@embeddededge.com>
Date: Thu, 27 Dec 2001 09:59:59 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
References: <15363.31192.101536.919771@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:


> Does anyone have any comments or objections?

That's a pretty good idea, and I have another one.  Name the
directory include/asm-ppc/ppc-platforms or something, then
have a symbolic link
	include/asm/platform -> include/asm-ppc/ppc-platforms/<board-file>

That way we can just #include <platform.h> instead of having lots
of ifdefs in upper level files to determine which one is needed.  If
we are moving files around, let's have some effect on actually making
it easier to use them, too.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
