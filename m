Subject: Re: bug in asm-ppc/div64.h
From: Bastien Nocera <hadess@hadess.net>
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15981.49825.808630.749299@nanango.paulus.ozlabs.org>
References: <1047380614.5038.7880.camel@bnocera.surrey.redhat.com>
	<15981.49825.808630.749299@nanango.paulus.ozlabs.org>
Content-Type: text/plain
Date: 11 Mar 2003 11:23:59 +0000
Message-Id: <1047381839.5038.7911.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,

On Tue, 2003-03-11 at 11:04, Paul Mackerras wrote:
>
> Bastien Nocera writes:
>
> > While chasing a date bug in smbfs with Urban Widmark, it so happened
> > that we stumbled across a bug in do_div on PPC 32bit, ie. it doesn't
> > work.
>
> Grab a copy of include/asm-ppc/div64.h and arch/ppc/lib/div64.S from
> a 2.5 tree.

Ben just pointed me to these files. I'll give it a try. Are there any
plans to backport these ? All my files on an SMB share appear with the
wrong dates because of that bug.

Cheers

PS: And sorry about the spam, and badly signed mails...
--
/Bastien Nocera
http://hadess.net

#2  0x4205a2cc in printf ("Oh my %s\n", preferred_deity) from
/lib/i686/libc.so.6 printf ("Oh my %s\n", preferred_deity);
Segmentation fault

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
