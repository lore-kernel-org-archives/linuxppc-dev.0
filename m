Date: Tue, 29 Oct 2002 12:20:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Tim M. Sanders" <tsanders@synergymicro.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel tree and 2.4.19
Message-ID: <20021029192059.GI688@opus.bloom.county>
References: <20021029114712.J25527@evilcat.ioinc.tucson.az.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021029114712.J25527@evilcat.ioinc.tucson.az.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 29, 2002 at 11:47:12AM -0700, Tim M. Sanders wrote:
>
> I have the latest linuxppc_2_4_devel tree from
> bk://source.mvista.com/linuxppc_2_4_devel.  I wanted to get the 2.4.19 "release"
> out of the tree.  I do bk clone -rv2.4.19 linuxppc_2_4_devel linuxppc_2419.  I
> know that the directory arch/ppc/platforms is suppose to be part of the 2.4.19
> tree, but it is not in the cloned tree.  What am I doing wrong?

v2.4.19 is kernel.org, as of 2.4.19, not the tree as of 2.4.19.  Do a
'bk changes', and look at where linuxppc_2_4 of the time was merged into
linuxppc_2_4_devel.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
