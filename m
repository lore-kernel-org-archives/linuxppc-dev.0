From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>, <paulus@linuxcare.com.au>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Date: Wed, 8 Nov 2000 21:54:58 +0100
Message-Id: <19341003142642.9550@192.168.1.10>
In-Reply-To: 
 <Pine.LNX.4.10.10011082109150.31984-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10011082109150.31984-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>To follow up on this: 2.2.18pre18 does not freeze on sleep or wakeup on my
>Lombard (no CD in drive, CD in drive, CD mounted, regardless).
>
>It does freeze, however, when I snooze the machine while using software
>cursor. Seems the software cursor interrupt needs to be stopped before
>turning off the display :-) Question: is software cursor support worth the
>hassle?

well, it's probably not difficult to fix. I'll give it a look.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
