From: benh@kernel.crashing.org
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	Matthias Grimm <joker@cymes.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pbbuttons, need some help
Date: Fri, 8 Mar 2002 13:33:01 +0100
Message-Id: <20020308123301.27605@mailhost.mipsys.com>
In-Reply-To: <20020307134140.56d70400.jpgarcia@execpc.com>
References: <20020307134140.56d70400.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The best way to get battery info now is to use to use /proc/pmu/ in newer
>(2.4) kernels.  My gkrellm-pmu plugin used to use adb directly, then PMUD,
>now /proc/pmu/.  I had to poke and prod at Paul Mackerras' Batmon to figure
>out O'Hare.  But /proc/pmu is transparent to what kind of system its on.
>Divide and conquer.  Nice that another conduit thats system independant
>exists.

Note that OHare in /proc/pmu is still known to be flawky as it seems
not all OHare based pbooks need the same formula. But at least it will
be fixed one day and I prefer indeed keeping that tricky code in a
single location. I do have some code to merge one of these days fixing
calculation for the 2400 for example.

>Along those same lines, I have a sugesstion for the gtk client for
>pbbuttons.  The program should use the X keycodes rather than associate
>with the daemon that controls the hardware.  This serves two purposes: X
>handles any client/server mess, and the GUI will be the system independant
>figurehead it should be (IMO).  Bastien wrote a similar program that uses
>the keycodes, so it could be used on any system with the keys, even an x86.
>(hadess.net)

Well, the daemon will still be needed to get the "special" keys on OHare
based powerbooks as I think those don't come via ADB.

>Thanks for working to improve the Linux user expirience. (and anyone else
>listening for keeping in touch with such ventures :)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
