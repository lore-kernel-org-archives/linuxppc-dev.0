Message-ID: <3D4FE40F.80802@embeddededge.com>
Date: Tue, 06 Aug 2002 10:58:23 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@directvinternet.com
Cc: Ppc Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm-ppc/io.h - 8260 conditional compile?
References: <NCBBIINEHIPFGJPLBEIFOEGHDKAA.acurtis@directvinternet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


acurtis@directvinternet.com wrote:

 > .... it should be implemented like the 8xx
> and 4xx processors, which it isn't without the conditional compiles.

No, it shouldn't.  The 4xx/8xx are unique because of the way they
have to map memory in support of cache coherent (i.e. uncached)
windows.  The 82xx processor family is a standard cache coherent 6xx
core and doesn't require any special software support.


> 8260 memory translations were broken in HHL 2.0 (Linux 2.4.2) Just making
> sure it isn't still broken in 2.4.17

How were they broken?


Thanks.


	-- Dan


>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
