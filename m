Message-ID: <3AFED89B.63B3599E@acm.org>
Date: Sun, 13 May 2001 11:55:23 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
References: <3AFE85F7.1F69E056@folkwang-hochschule.de> <20010513131352.30216@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
>
> Not exactly. I use pmud 0.7-2 on a Pismo PowerBook (which is approx
> the same motherboard as the TiBook).
>
> >i will use snooze -f for a while to check if that cures it, and
> >start nagging stephan if it does :)
>

Version on my TiBook:
pmud-0.7-2

I also get this line when starting up:
pwrctl: no function for PMU 12

Are there specifics for the TiBook or should I alter the script for
pwrctl_G3?

More information:

I just did a series of sleep/wakeups.  No problem...  pmud is reporting
the AC connection/disconnection properly as well.  I have noticed that
snooze in console does not work, even with a USB mouse attached.  I
don't know if that helps at all.  Oh and the sleep/wakeups where with
the USB mouse both _detached_ and _atached_ all seems fine.  But, the
trackpad will not wake the machine only a keypress on the keyboard.

I suppose this does not help much though.  Is there any specific
information which I could give you to help you out Ben?  The messages
file seems to be standard stuff.

Sorry,
Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
