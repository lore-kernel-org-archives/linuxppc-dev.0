Message-ID: <20030417080220.36050.qmail@web41806.mail.yahoo.com>
Date: Thu, 17 Apr 2003 01:02:20 -0700 (PDT)
From: Cedric Aubert <cedric_aubert@yahoo.fr>
Reply-To: cedric_aubert@yahoo.fr
Subject: Re: Interdependence of gcc to glibc/linuxheaders?
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <F0B628F30F48064289D8CCC1EE21B7A80C486C@mvebe001.americas.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am not an expert but I have just build my own gcc
last day.

I have understand (may be wrong but I don't think :-)
that when you build some gcc, you need like you say
the kernel headers and a libc. The version of kernel
headers option is not very important, the lastest
is better but you can build some other kernel version
with your gcc. But for the libc, it's different, you
will make a choice, if you want uclibc or glibc, your
gcc will be make and always use this libc. So if you
want to use another libc you had to rebuild your gcc.
But another solution you can build your gcc with glibc
an after build uclibc with this gcc an you will have a
another gcc patched for uclibc for example you will
have for glibc powerpc-linux-gcc and for uclibc
powerpc-uclibc-gcc.

For my self I prefer to build my own uclibc gcc
(3.2.2)
directely with the uclibc toolchain (very easy to do)

Cedric

--- Darin.Johnson@nokia.com wrote:
>
> I notice that during the builds of GCC it requires
> linux headers and actually copies headers and
> libraries from glibc.  Does this make GCC dependent
> later upon glibc and the particular linux headers?
>
> In other words, after GCC is built, how difficult is
> it to replace everything with a different glibc, or
> uclibc, without having to recompile GCC?  If it's
> possible, which directories are safe to clobber and
> replace, and which need to be kept?
>
> Darin Johnson
>
>


=====
AUBERT Cedric
SDEL Controle Commande
rue Nungesser & Coli
44860 St Aignan de Grand Lieu

E-mail : cedric_aubert@yahoo.fr
Http : http://www.controle-commande.sdel.fr/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
