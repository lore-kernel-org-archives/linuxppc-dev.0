Content-Type: text/plain;
  charset="iso-8859-1"
From: Leonardo Pereira Santos <lsantos@pd3.com.br>
To: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does 'Bitkeeper' work according to the 'kernel sources' link @ pp cpenguin.org
Date: Thu, 23 Jan 2003 18:29:05 -0200
References: <995FF289C9D69747A09E42992644595405B2361D@penguin.adic.com>
In-Reply-To: <995FF289C9D69747A09E42992644595405B2361D@penguin.adic.com>
MIME-Version: 1.0
Message-Id: <200301231829.05981.lsantos@pd3.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hehe, I got that impression the first time I looked at what I had downloaded.
You must issue some other comands from bk. Read BK's faq and documention to
know what to do. If I remember correctly, you'll have to do something like
#bk get

At the linux top directory(where Makefile should be). There are other
parameters, to tell bk to do this recursively.

On Thursday 23 January 2003 18:03, brian.auld@adic.com wrote:
> I've successfully installed the cross-compiler for powerpc-linux and am
> trying to build the kernel. There is a HOWTO @ ppcpenguin.org that tells
> you how to cross-compile ... which is what I'm following.
>
> This is my first time using bk. I bk'ed linuxppc_2_4, but it appears that
> the whole thing does not get downloaded. For example, the
> "scripts/lxdialog" directory in the kernel source tree does not have any
> contents other than the SCCS directory. I find this is a consistent problem
> with a smattering of diretories within the kernel source tree. I cannot
> successfully execute "make menuconfig" and am stumped.
>
> Can anyone confirm whether or not the instructions under the "kernel
> sources" link at ppcpenguin.org are accurate or not?
>
> Thanks
>
> -- Brian
>
>

- --
This is Linux country.
On a quiet night, you can hear Windows reboot.

Leonardo Pereira Santos
Engenheiro de Projetos
PD3 Tecnologia
av. Pará 330/202
(51) 3337 1237

Today Fortune tells us:
Unseen University had never admitted women, muttering something about
problems with the plumbing, but the real reason was an unspoken dread that
if women were allowed to mess around with magic they would probably be
embarrassingly good at it ...
		-- Terry Pratchett, "The Light Fantastic"


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
