From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <michdaen@iiic.ethz.ch>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus interrupt -1
Date: Fri, 19 Jan 2001 10:50:46 +0100
Message-Id: <19341214032230.10260@mailhost.mipsys.com>
In-Reply-To: <3A6775B0.2108F1DE@relog.ch>
References: <3A6775B0.2108F1DE@relog.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I have tons of messages like this in my logs:
>
>Jan 18 23:06:54 pismo kernel: Bogus interrupt -1 from PC = c00065d0
>
>Anyone knows where these (may) come from?

Which kernel ?

We do get tons of "short" interrupts on the Pismo and the iBook. I don't
know why exactly. I used to filter out the error message, it looks like
someone put it back.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
