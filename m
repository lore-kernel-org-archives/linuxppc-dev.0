Date: Sun, 8 Oct 2000 20:17:59 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibook ttyS0 (modem), and pppd problem, linux-2.2.17pre20ben2
Message-ID: <20001008201759.A16105@suse.de>
References: <Pine.SOL.4.10.10010080013120.22269-100000@joust.gpcc.itd.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOL.4.10.10010080013120.22269-100000@joust.gpcc.itd.umich.edu>; from cziesler@umich.edu on Sun, Oct 08, 2000 at 01:58:01PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 08, Conrad H Ziesler wrote:

>
> The first time i run pppd after reboot, everything works great.
>
> however, if the remote host abruptly hangs up, then all future pppd
> instances yield the following trace in syslog:
>
> Oct  7 18:35:15 mwatt pppd[7318]: pppd 2.3.11 started by root, uid 0
> Oct  7 18:35:19 mwatt pppd[7318]: Hangup (SIGHUP)
> Oct  7 18:35:19 mwatt pppd[7318]: Connect script failed
>
> that is, pppd aborts without ever running chat.
> nothing i seem to do fixes this except reboot.
>
> note: if pppd exits cleanly from a session, then the next time it runs has
> no problem, however if the link gets disrupted, then the next (and all
> future) times it fails to work.
>
> i'm guessing there is some state in the serial driver that
> doesn't get cleared in all cases, or some such...

How looks the init string for the modem and does it work in MacOS?
If yes, what modem script do you use in MacOS?



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
