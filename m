In-Reply-To: <19991024204740.022621@smtp.calvacom.fr>
Date: Mon, 25 Oct 1999 18:39:52 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: iBook/UMA pre2
Message-Id: <19991025183952.002644@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 24, 1999, BenH <bh40@calva.net> wrote:

>I've just updated my iBook patches, the PMU shutdown issue is gone (it
>was simply not liking the kbd LEDs request, I should have found this one
>earlier). I still don't receive CB1 interrupts however and the timer I'm
>using may not be safe (I can probably not be sure of MacOS setting on
>this timer) and is slow enough to be annoying with the trackpad.

I've found more problems with the PCI code, I'll upload a new version
later tonight or tomorrow with also correct support for cascaded bridges
(so it should work with the G4 and it's DEC bridge).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
