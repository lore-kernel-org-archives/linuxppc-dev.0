From: Benjamin Herrenschmidt <bh40@calva.net>
To: Brad Midgley <brad@turbolinux.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: yaboot lockups (IBM travelstar)
Date: Tue, 30 May 2000 18:52:33 +0200
Message-Id: <20000530165233.23353@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.20.0005300927020.16755-100000@mail.turbolinux.com>
References: <Pine.LNX.4.20.0005300927020.16755-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, May 30, 2000, Brad Midgley <brad@turbolinux.com> wrote:

>I just put a 12gig IBM drive in my bronze powerbook. Now, if I try to
>coldboot using yaboot, the kernel locks up just after it prints out that
>it discovered the ide controllers. I don't think this was happening with
>the old 4gig drive.
>
>I have to use bootx if I'm booting the machine cold. yaboot works for warm
>boots.
>
>Using paul's rsync 2.2.15, yaboot 0.6.

That's a known problem with the Lombard and has nothing to do with your
disk. Basically, what happens is that on a cold boot, something is
screwed up in the ATI chip initialisation, and that cause the console
accel to hang as soon as it tries to scroll the screen. The problem
doesn't happen on warm boot after MacOS had a chance to load at least once.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
