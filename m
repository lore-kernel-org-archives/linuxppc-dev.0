Message-ID: <4087CE7D.1090908@embeddededge.com>
Date: Thu, 22 Apr 2004 09:54:05 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: challaharikumar <challaharikumar@tataelxsi.co.in>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADS8260 Hang
References: <001101c42832$ec117760$3401080a@telxsi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


challaharikumar wrote:

> I tried tracking down where the hang could be and ended up
> at the RFI instruction where its waiting to complete the MMU
> initialization. The system executes SYNC instruction and then hangs.
> (arch/ppc/kernel/head.S)

Your tools are fooling you, this isn't the problem.  The mapping of
memory for 82xx works just fine.  There may be something specific to
your board that is incorrect, but this mmu initialization at this
point is not the problem.

Why are you using such an old kernel?  Please update to something
more recent.

	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
