Date: Fri, 12 Apr 2002 08:25:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sporadic kernel panic during boot (MPC8xx, FEC)
Message-ID: <20020412152509.GQ759@opus.bloom.county>
References: <3CB6A2FE.62FFB14E@imc-berlin.de> <20020412133332.AA7E211258@denx.denx.de> <20020412150803.GO759@opus.bloom.county> <3CB6F9B7.16378395@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CB6F9B7.16378395@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 12, 2002 at 05:13:59PM +0200, Steven Scholz wrote:
>
> Tom Rini wrote:
>
> > > Define stable :-(
> > Well, whichever ChangeSet is the merge of someplace:/.../linux_2_4 into
> > someplace:/.../linuxppc_2_4 is the merge into linuxppc_2_4.
>
> ??? Excuse me? :-(
> What did you say?

Well, in the linuxppc_2_4 and linuxppc_2_4_devel trees (this doesn't
hold true for the Linus and Marcelo BK trees since they work differently):
ChangeSet@1.604, 2002-04-05 10:17:36-07:00, trini@opus.bloom.county
  Merge opus.bloom.county:/home/trini/work/kernel/pristine/linux_2_4
  into opus.bloom.county:/home/trini/work/kernel/pristine/linuxppc_2_4

ChangeSet@1.2.2.138, 2002-04-05 10:11:39-07:00, trini@opus.bloom.county
  patch-2.4.19-pre5-pre6
  TAG: v2.4.19-pre6


So 1.604 will get you 2.4.19-pre6 in the linuxppc_2_4 tree.

In the linuxppc_2_4_devel tree:
ChangeSet@1.900, 2002-02-26 17:37:17-07:00, trini@opus.bloom.county
  Merge opus.bloom.county:/home/trini/work/kernel/pristine/linuxppc_2_4
  into opus.bloom.county:/home/trini/work/kernel/pristine/linuxppc_2_4_devel

ChangeSet@1.118.1.473, 2002-02-26 17:31:25-07:00, trini@opus.bloom.county
  Merge opus.bloom.county:/home/trini/work/kernel/pristine/linux_2_4
  into opus.bloom.county:/home/trini/work/kernel/pristine/linuxppc_2_4

ChangeSet@1.2.2.133, 2002-02-26 17:28:14-07:00, trini@opus.bloom.county
  The actual change in 2.4.18-rc4 got applied twice, revert.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
