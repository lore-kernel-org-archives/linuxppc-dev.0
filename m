Message-ID: <3BCAF4D2.D41EE8C4@mvista.com>
Date: Mon, 15 Oct 2001 10:38:10 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: interesting line in process.c
References: <15304.11248.720092.645241@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
>
> I'm intrigued by this line, line 276 in arch/ppc/kernel/process.c in
> linuxppc_2_4_devel:

I try to move this to other fault handlers where there is some 4xx
specific stuff already defined, but it keeps moving around and finding
its way back here.

> Which brings up another question that I have been meaning to ask: what
> is the rationale for adding the dbcr0/1 fields to the ptrace struct
> for 4xx?

I dunno.  They have also been moving around during the 4xx port.
I just put them where the folks that send the patches have them.
I'll take a look at this since gdb is currently broken on 4xx.
They have to be context switched, and maybe someone though gdb should
have access to them.....


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
