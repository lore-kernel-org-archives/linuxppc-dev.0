From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15613.14670.80929.155220@argo.ozlabs.ibm.com>
Date: Wed, 5 Jun 2002 08:03:58 +1000 (EST)
To: frowand@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pt_regs.dbcr0/1
In-Reply-To: <3CFD3747.B88C1BA5@mvista.com>
References: <15608.22230.504008.818858@argo.ozlabs.ibm.com>
	<3CFD3747.B88C1BA5@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Rowand writes:

> That's a very important sentence...  If you are going to modify any of
> the 4xx debug infrastructure, please be sure that you understand how
> gdb (via ptrace.c), kgdb (via ppc_stub.c), and jtag debuggers use the
> infrastructure and how they can interact.  Other interesting files

It would be really nice if you would document this somewhere...

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
