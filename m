Message-ID: <3BA7FFAA.11B7B890@mvista.com>
Date: Tue, 18 Sep 2001 21:15:06 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Init acting strange
References: <001e01c140ac$88e8b830$fb5a01d9@crtc.corp.mot.com> <3BA7FE96.CA24D4EE@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kevin Fry wrote:
>
> I've been trying to get init working for a while now but I can't getting
> logging in to work correctly, and I'm out of ideas, maybe someone can help
>
> I'm using HHL 2.0 and the ramdisk is made from the target app rpms. I'm using
> the default passwd file. Do shadow passwords or anything like that need to be
> compiled in the kernel for the hhl2.0 login stuff to work??

Look at your log files, located in /var/log/.  You should see some type
of an error message.  My guess from your question is that you are
missing /bin/login, the shadow tools.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
