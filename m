From: Benjamin Herrenschmidt <benh@mipsys.com>
To: Mario Scarpa <m.scarpa@mondonet.net>,
        LinuxPPC Developers List
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: seemingly random lock-up with kernel 2.2.17p7
Date: Wed, 5 Jul 2000 17:43:02 +0200
Message-Id: <20000705154302.13586@mailhost.mipsys.com>
In-Reply-To: <396353DD.7F1C5E7A@mondonet.net>
References: <396353DD.7F1C5E7A@mondonet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I've got a lombard (400MHz, 64MB) and had precisly the same
>behaviour: I was playing some MP3s (mpg123 under X 3.3.6-8
>debianPPC) and the system just crashed two times this morning;
>coz I tried to ping it from another machine and coz I tried
>to shut X down but everything was failing (definitively a system
>crash I would say)...
>Another brick in the wall...the MP3 I was listening this morning
>where both on a CDROM and on a HD and yesterday, just doing a lot
>of HD traffic (moving around some huge dirs) I had another lock;
>it doesn't happen so often (would say never)...could it be something
>related to the IDE driver ? Kernel here 's 2.2.17pre7 rsynced
>from linuxcare.

Thinking about it... you may have triggered a threading kernel bug that
was fixed very recently in mmap (and sounds usually uses mmap a lot, X too).

I'll post a new kernel that has this fix today or tomorrow, let's see if
it corrects your problem.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
