Date: Thu, 7 Mar 2002 13:41:40 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Matthias Grimm <joker@cymes.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pbbuttons, need some help
Message-Id: <20020307134140.56d70400.jpgarcia@execpc.com>
In-Reply-To: <3C87B6C8.9070905@cymes.de>
References: <3C852E12.3030300@cymes.de>
	<20020306090814.15511@mailhost.mipsys.com>
	<3C87B6C8.9070905@cymes.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings.

The best way to get battery info now is to use to use /proc/pmu/ in newer
(2.4) kernels.  My gkrellm-pmu plugin used to use adb directly, then PMUD,
now /proc/pmu/.  I had to poke and prod at Paul Mackerras' Batmon to figure
out O'Hare.  But /proc/pmu is transparent to what kind of system its on.
Divide and conquer.  Nice that another conduit thats system independant
exists.

Along those same lines, I have a sugesstion for the gtk client for
pbbuttons.  The program should use the X keycodes rather than associate
with the daemon that controls the hardware.  This serves two purposes: X
handles any client/server mess, and the GUI will be the system independant
figurehead it should be (IMO).  Bastien wrote a similar program that uses
the keycodes, so it could be used on any system with the keys, even an x86.
(hadess.net)

Thanks for working to improve the Linux user expirience. (and anyone else
listening for keeping in touch with such ventures :)

Hope this helps.

--
Joseph P. Garcia    http://www.lycestra.com/    http://lidar.ssec.wisc.edu/
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
