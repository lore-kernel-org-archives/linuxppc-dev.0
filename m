Message-ID: <20000327170802.25561.qmail@web1703.mail.yahoo.com>
Date: Mon, 27 Mar 2000 09:08:02 -0800 (PST)
From: Gabriel Ricard <g_ricard@yahoo.com>
Subject: Re: PCI address collisions on 2.3.x kernels?
To: Robert Shaw <rshawppc@netscape.net>, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got the same thing. Not sure why, but it looked like
a lot of the PCI devices were stepping on each other.
I only booted 2.3.* a couple of times but I never had
problems with it finding my drives. Then again, I
don't have IDE in the machine I was booting it on.

Did you copy your old .config to the new kernel src
dir and run make oldconfig? Or just choose the same
options? Are you sure you had the correct IDE support
built in?

--- Robert Shaw <rshawppc@netscape.net> wrote:
>
> I've been trying for over a week now to compile the
> 2.3.x series kernel on my
> B&W G3 machine. Everytime I get this annoying "PCI
> address collision" error
> right at the start (after the penguin graphic
> appears). It goes past this and
> behaves like it's booting ok, but then it tries to
> access the IDE buses and
> fails to find anything and I get the infamous
> "Rebooting in 180 seconds..."
> message.
>
> Can someone please help!! I'm stumped as to why this
> is happening. Has anyone
> else seen this? I don't think its a config problem,
> as I'm using the same
> settings I always have that work for the latest
> 2.2.15pre14 kernel in the
> stable tree.
>
> I think if I can get rid of the "PCI address
> collision" errors, that my IDE
> bus will get recognized properly.
>
> Any ideas? Please!
>
> TIA.
>
>
> -Robert
>  mailto:rshaw@linuxppc.org
>  icq:45688313
>  http://www.linuxppc.org/BlueG3/
>
>
>
>

=====
Gabriel Ricard
g_ricard@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
