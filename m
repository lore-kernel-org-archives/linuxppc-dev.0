Message-ID: <37DEF30C.EFB188F6@ctam.com.au>
Date: Wed, 15 Sep 1999 11:14:53 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: sébastien tadéoni <sebastien_tadeoni@yahoo.fr>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem for compiling linux-2.2.5-embedded
References: <19990914142953.21439.rocketmail@web601.yahoomail.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sébastien tadéoni wrote:

> I've some problems with the cross-compilation of the 2.2.5-embedded
> kernel for MPC860 (configure for a MBX card).
>
> ppc_ksyms.c:77:'isa_io_base' undeclared here (not in a fonction)
>
> ppc_ksyms.c:77:'initializer element for '--ksymtab_isa_io_base.value'
> is not constant
>
> In the ppc_ksyms.c I see EXPORT_SYMBOL(isa_io_base) and I don't no what
> it minds.

First join the new linuxppc-embedded mailing list.  This is a ppc-embedded
problem and there is no need to hassle the ppc-users or ppc-developers.

I had these problems too.  It is definately a configuration problem.  I am
using the latest embedded source mpc8xx-2.3.10.tgz but had the same
problems with embedded-2.2.5.  Send your .config file.

Things you should NOT have included are :
- serial support and serial-console support.  I know this sounds wrong but
that's the way it is.
- virtual terminals
- make sure that no network cards are selected.

Brendan Simon.

PS. I think there is a sample configuration file in embedded-notes.txt or
mbx-notes.txt on the ftp site.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
