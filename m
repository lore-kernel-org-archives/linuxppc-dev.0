Date: Mon, 21 Jan 2002 12:03:04 +0100 (CET)
From: Christian Pellegrin <chri@infis.univ.trieste.it>
To: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Debugging with gdb problem
In-Reply-To: <CA78D1B723D8D411AF0300508BDCF74F871337@NTCORREO>
Message-ID: <Pine.LNX.4.33.0201211201550.21331-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 21 Jan 2002, GOTZON ASTONDOA wrote:

>
> Hi everibody:
>
> 	I want to start debugging our applications with gdb and gdbserver,
> but it does not work.
> 	The gdbserver says:
> 		chroot /nfs gdbserver 10.0.17.20:2345 sample
> 		Process sample created; pid = 28
> 		getprotobyname: No such file or directory.
> 		Exiting
> 	And the gdb says:
> 		chroot /nfs gdbserver 10.0.17.20:2345 sample
> 		Process sample created; pid = 28
> 		getprotobyname: No such file or directory.
> 		Exiting
>
> 	I am using busibox. It would be a problem of the busibox shell?How
> can y solve the problem?
>


Hi, just copy the file /etc/protocols from some Linux distro.

Bye!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
