In-Reply-To: <314790494.20040827191642@varma-el.com>
References: <927068331.20040827153454@varma-el.com> <E832C827-F839-11D8-BF10-003065F9B7DC@embeddededge.com> <314790494.20040827191642@varma-el.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <735B3B8C-F851-11D8-8E7D-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Re[2]: [RFC] Remove G2_LE core decl from CLASSIC_PPC part of arch/ppc/kernel/cputable.c
Date: Fri, 27 Aug 2004 13:49:31 -0400
To: Andrey Volkov <avolkov@varma-el.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 27, 2004, at 11:16 AM, Andrey Volkov wrote:

> Maybe ~2K of rubbish for somebody "few" - for me not :) (don't forget
> its embedded platform).

If you have a system of this magnitude where a couple of Kbytes is
going to be the difference between success or failure, I'd suggest
looking other places than adding an superfluous #ifdef around
the cpu table.

There are lots of places in the kernel where thorough analysis
and careful configuration will save you lots more than this and
probably make a difference.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
