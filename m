To: sprenger <sprenger@in.tum.de>
Subject: Re: xf4 and lombard
CC: linuxppc-dev@lists.linuxppc.org
References: <39A5E3F7.1030409@in.tum.de>
Content-Type: text/plain; charset=US-ASCII
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 25 Aug 2000 20:48:53 +0200
In-Reply-To: sprenger's message of "Fri, 25 Aug 2000 03:11:51 +0000"
Message-ID: <87em3dyy5m.fsf@hades.nocrew.org>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


sprenger <sprenger@in.tum.de> writes:

> my x-server is working now after using yaboot - thanks !
>
> using a 2.2.17pre15 worked fine, but with a 2.4-test6 kernel the
> x-server crashed often especially under heavy load - like compiling
> mozilla-m17 !? but even on the console the build would stop three times
> with error 132, just had to restart the build - strange .
> i just upgraded to 2.4-test7, and the x-server seems to be stable now
> (compiling a new mozilla while using the old one - really a heavy load
> ...). but now i have some garbage (several blue dots) on my screen,
> especially on the "gkrellm"-window.
> any idea ?
>
> i will try a new rsynced version of the ati-driver during the weekend.

May I just ask.. how the heck did you get xf4 running on lombard? :)

All I manage to get is a black screen and I can't do anything anymore.
The machine is still running, so I can reboot it via network.

It's a lombard/333 running 2.4.0-test6.

xf4 is compiled from sources found on a link from the instructions
at linuxppc.org and the rsynced version of the ati-driver, as of
about 17.00 CET 2000-08-25.

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
