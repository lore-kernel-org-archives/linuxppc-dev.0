From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15981.49825.808630.749299@nanango.paulus.ozlabs.org>
Date: Tue, 11 Mar 2003 22:04:01 +1100 (EST)
To: Bastien Nocera <bnocera@redhat.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bug in asm-ppc/div64.h
In-Reply-To: <1047380614.5038.7880.camel@bnocera.surrey.redhat.com>
References: <1047380614.5038.7880.camel@bnocera.surrey.redhat.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bastien Nocera writes:

> While chasing a date bug in smbfs with Urban Widmark, it so happened
> that we stumbled across a bug in do_div on PPC 32bit, ie. it doesn't
> work.

Grab a copy of include/asm-ppc/div64.h and arch/ppc/lib/div64.S from
a 2.5 tree.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
