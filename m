Date: Fri, 17 May 2002 07:47:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: Lao Dingxiong <laodx@gzjpg.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: How can I run linux on MOTOROLA MVME5100 ?
Message-ID: <20020517144709.GI20456@opus.bloom.county>
References: <20020517121100.SM00168@------> <20020517095318.C1818@ipnpcu5.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020517095318.C1818@ipnpcu5.in2p3.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 17, 2002 at 09:53:18AM +0200, Xavier Grave wrote:
>
> Le ven, 17 mai 2002 05:46:27, Lao Dingxiong a ?crit :
> >
> >I have heard that the newly linux kernel(2.4, or above) can support 5100.
> >So I compiled a 2.4.7 kernel, but it can't work!!!
> >I want to know should I patch the kernel with a 5100 supported patch?
> >if yes, where can I get this patch?
> >Thanks for your help.
>
> Where did you take your kernel sources ?
> I'm using a 2.4.11 kernel from http://ppc.bitkeeper.com/

Or read:
http://penguinppc.org/dev/kernel.shtml.

You'll want to get the linuxppc_2_4_devel tree, and the MVME5100 support
quite probably needs to be updated to use 'openpic_set_sources' and have
it's OpenPIC_InitSenses table-redone.  arch/ppc/platforms/lopec_setup.c
should hopefully have enough comments to explain what needs to be done
to the MVME5100 files.  Tested patches would be greatly appreciated.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
