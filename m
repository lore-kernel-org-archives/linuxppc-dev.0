Date: Thu, 11 May 2000 11:17:04 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Lombard hard freeze (update: mem>64MB)
In-reply-to: <20000511171009.23577.qmail@web1705.mail.yahoo.com>
To: Gabriel Ricard <g_ricard@yahoo.com>, Seanano <sto9013@ksu.edu>,
        Bernhard Reiter <bernhard@intevation.de>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <p04310100b540a96a5815@[134.114.15.89]>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <20000511171009.23577.qmail@web1705.mail.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:10 AM -0700 5/11/00, Gabriel Ricard wrote:
>I'm using yaboot too. Does your kernel intialize the
>video correctly when you first boot the machine up
>from a cold state (as in, it was shutdown, not a
>reboot)? I have to go into OF from a cold state, and
>boot my macos partition just to the point where the
>ROM initializes the video with a grey screen,
>otherwise, I get this odd lockup when I boot into
>Linux. As the kernel messages scroll down the screen
>its fine until it has to scroll the screen up, it just
>locks up when it does that. What kernel, yaboot, and
>LinuxPPC (or other distro) version are you using?

Yes, my Pismo will initialize the video correctly from a cold boot.
I'm using yaboot with kernel 2.2.15-pre19 I believe.

Tim
--

-------
Tim Wojtulewicz           Tim.Wojtulewicz@nau.edu
(520)523-2543             http://dana.ucc.nau.edu/~tjw4

In the Windows world, you are one click away from
harming yourself -- Elias Levy, Bugtraq

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
