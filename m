Message-ID: <3C893BB9.6040002@cymes.de>
Date: Fri, 08 Mar 2002 23:31:21 +0100
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pbbuttons, need some help
References: <3C852E12.3030300@cymes.de>	<20020306090814.15511@mailhost.mipsys.com>	<3C87B6C8.9070905@cymes.de> <20020307134140.56d70400.jpgarcia@execpc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph P. Garcia wrote:
Hi,

 > The best way to get battery info now is to use to use /proc/pmu/ in newer

> (2.4) kernels.  My gkrellm-pmu plugin used to use adb directly, then PMUD,
> now /proc/pmu/.  I had to poke and prod at Paul Mackerras' Batmon to figure
> out O'Hare.  But /proc/pmu is transparent to what kind of system its on.
> Divide and conquer.  Nice that another conduit thats system independant
> exists.


Yes, you are right. Why do something again what's already done. I looked
into the kernel source, afterwards into PMUD and then I thought that's
the way and other possibilities didn't come into my mind although I knew
/proc/pmu. So I will borrow some code from gkrellm-pmu for that task. ;-)


> Along those same lines, I have a sugesstion for the gtk client for
> pbbuttons.  The program should use the X keycodes rather than associate
> with the daemon that controls the hardware.  This serves two purposes: X
> handles any client/server mess, and the GUI will be the system independant
> figurehead it should be (IMO).  Bastien wrote a similar program that uses
> the keycodes, so it could be used on any system with the keys, even an x86.
> (hadess.net)


I didn't understand excactly what you mean. The GTK client is only a
simple stupid program that will do what it's told from the server. It
hasn't any own input routines except the message queue where the
messages from the server arrive. It doesn't get in contact with any
keycodes, neither from X nor from terminal.

What do you mean with 'client/server mess'? I don't use the X-protokoll
for communication and I don't think it would make much sense. We would
hardly benefit from the X-protokoll because the network transparency
isn't needed here. We only want to make the handling of our machines
more comfortable. Or have I misunderstood you here?


> Hope this helps.


Discussions will always help :-) Who else would turn me arround 180
degrees in a blind alley ;-)

  Matthias


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
