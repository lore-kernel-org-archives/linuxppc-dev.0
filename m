To: <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SUNGEM config
References: <87k7th2ujl.fsf@theorie.physik.uni-muenchen.de>
	<20020213172847.23608@mailhost.mipsys.com>
Reply-To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
From: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Date: 14 Feb 2002 06:06:40 +0900
In-Reply-To: <20020213172847.23608@mailhost.mipsys.com>
Message-ID: <87u1slf5wf.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Can you tell me more about those machine checks ?

I can send you the usual output, it's still in my logs.

> I suspect they happen if you try to read the registers while the
> interface is shutdown, in which case the GEM chip is down.

Precisely.  That's what the ifd daemon does, it polls the device once
every second via that ioctl in order to see whether it is connected or
not.

Regards, Jens.

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
