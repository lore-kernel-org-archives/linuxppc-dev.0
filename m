Message-ID: <39AEC1C7.E0894CFB@wanadoo.fr>
Date: Thu, 31 Aug 2000 22:36:23 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: daenzerm@student.ethz.ch, Joseph Garcia <jpgarcia@execpc.com>,
        Gabriel Paubert <paubert@iram.es>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 problems
References: <Pine.HPX.4.10.10008311808260.15978-100000@gra-ux1.iram.es>
			 <39AE85BD.1B4651BB@relog.ch> <39AEAC18.7EA022BC@execpc.com> <39AEAF7F.B36AFC53@relog.ch> <39AEB110.346A9DC9@embeddededge.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Michel Dänzer wrote:
>
> > Haven't seen that.
>
> My 7200 won't even boot.....

On my 6400, both bk-test8 and pmac-devel-test7 are running nicely. The
one major problem is random sudden freezes that can happen after some
minutes or after 3 days and which have been reported a couple of times
by others, too. It is like the ADB interrupt dies. There are no
messages, the computer is still alive, it goes on compiling or
downloading, and today I even could ssh in over the net, but locally,
keyboard and mouse are dead, even MagicSysRq, the only working key combo
is ctrl-cmd-power :-(

I never saw this with 2.2.X kernels (not recently, in any case).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
