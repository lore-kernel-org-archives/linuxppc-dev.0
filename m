From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: crash on sleep with 2.4.19-pre4-ben0
Date: Fri, 29 Mar 2002 05:57:09 +0100
Message-Id: <20020329045710.13227@smtp.wanadoo.fr>
In-Reply-To: <E16rLfu-00009C-00@piglet.grunz.lu>
References: <E16rLfu-00009C-00@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>AAArrgh! It doesn't crash anymore now! Thanks for the solution ;-))).
>
>Seriously, after adding a call to backtrace upon entry of xmon's main
>(infinte) loop, I've not been able to reproduce the crash. And I tried
>sleeping and waking up in a loop at least 50 times...
>
>I'll keep on trying.

Hrm, look at timing related race in one of the driver, maybe IDE or
ethernet...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
