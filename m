Message-ID: <3CFCF745.8090002@embeddededge.com>
Date: Tue, 04 Jun 2002 13:22:13 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pt_regs.dbcr0/1
References: <15608.22230.504008.818858@argo.ozlabs.ibm.com>	<3CFC16A4.7090902@embeddededge.com> <15612.18916.648386.173632@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> So has anyone done a 4xx-aware gdb yet?

Not to my knowledge.  Daniel Jacobowitz (drow) has discussed it a little,
but I have not heard much about it lately.

> ....  I think we are in violent agreement. :)

Not again......It must be that Aussie English :-)


> ..... gdb + xmon/kgdb
> may be possible but we will have to see how complex it looks once we
> know what the kernel support for gdb looks like.

I believe we have tied the BDI context switch configuration option to
allowing external debugging by ensuring the kernel doesn't mess around
with the debug registers.  We have at least discussed doing it.  As
long as we properly context switch the debug registers, all of the software
modes should coexist happily.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
