Date: Thu, 28 Nov 2002 20:01:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4
Message-ID: <20021129030135.GD25660@opus.bloom.county>
References: <200211290248.SAA27913@hostme.bitkeeper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200211290248.SAA27913@hostme.bitkeeper.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 28, 2002 at 06:48:10PM -0800, ppc@bkbits.net wrote:

> ChangeSet@1.722, 2002-11-28 19:44:54-07:00, trini@kernel.crashing.org
>   Merge kernel.crashing.org:/home/trini/work/kernel/pristine/linux_2_4
>   into kernel.crashing.org:/home/trini/work/kernel/pristine/linuxppc_2_4
>   TAG: v2.4.20_linuxppc_2_4
>
>   Makefile@1.178, 02-11-28 19:44:13-07:00, trini@kernel.crashing.org
>     Auto merged
>
> ChangeSet@1.2.2.167, 2002-11-28 19:43:57-07:00, trini@kernel.crashing.org
>   patch-2.4.20-rc4-final
>   TAG: v2.4.20
>
>   Makefile@1.19.1.157, 02-11-28 08:55:34-07:00, trini@kernel.crashing.org
>     Import patch patch-2.4.20-rc4-final

And with the start of this, all final releases in the linuxppc_2_4 and
linuxppc_2_4_devel trees will have a tag for the merge of that release
into that tree.  Which means that in a linuxppc_2_4_devel tree, bk
export -tplain -rv2.4.20_linuxppc_2_4_devel will get the
linuxppc_2_4_devel tree, as of 2.4.20.

Tags might be added to previous revisions if time permits, or someone
produces a nifty script to find out what revisions corrispond to what :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
