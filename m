Date: Wed, 24 May 2000 09:30:50 +0200
Subject: Re: Debian pmud package available 
From: Stephan Leemburg <stephan@jvc.nl>
To: Wilhelm Fitzpatrick <rafial@well.com>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Sergio Brandano <sb@dcs.qmw.ac.uk>, <linuxppc-dev@lists.linuxppc.org>,
        <debian-powerpc@lists.debian.org>
Message-ID: <B55151CA.E6B6%stephan@jvc.nl>
In-Reply-To: <Pine.GSO.4.10.10005231723200.1902-100000@well.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on 24-05-2000 02:31, Wilhelm Fitzpatrick at rafial@well.com wrote:

>> OK, the Debian package plus diff/changes/dsc stuff is up for testing on
>> ftp.biophys.uni-duesseldorf.de:/pub/linux/powerpc - it's not a final
>> version yet, I need to figure out how to have the Debian postinst
>> automatically create the /etc/rc*.d symlinks. If someone wants to play
>> with it, go ahead.
>
> I'm testing, seems good on my PB3400.  It's nice being able to have the
> network interface cycled automatically, and I added "trackpad notap" to my
> wakeup sequence so I don't forget ;)
>
> A few questions --
>
> what is xmouse?  Why is it included?

xmouse is for some of our users... we have a couple of salespersons walking
around with Wallstreets and LinuxPPC on it, so they can run our rdbms
programs. As they are salespersons, we keep everything unix away from them.
They complaint that the mouse-settings weren't saved on reboot, so I made
xmouse, which asks the X-server what the current settings are and can also
set (a la xset -m) the mouse settings in the server. I included it as a
utility, it's not related to powermanagement, but it is to restoring stuff
at booting.

>
> Also, the gnome battery monitor applet tells me I don't have APM support.

Because it looks for /proc/apm, I guess...

> Batmon is okay, but I'd really like to have panel applet battery level.

See if you can change the path /proc/apm in the applet to /etc/power/apm.

> Is this just not supported yet?

Yes it is, note to use the -a flag for pmud. I plan to build a
apm-kernel-module which supplies apm on top of powerbook pmu, so in the near
future hopefully all apm stuff runs unmodified.
--
Stephan

>
> -raf
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
