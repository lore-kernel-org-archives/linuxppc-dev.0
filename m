Date: Tue, 24 Apr 2001 13:48:07 -0400
From: ultrapenguin@netscape.net (jeramy b smith)
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rsync access through NAT?
Mime-Version: 1.0
Message-ID: <5C7B5EF3.57179C98.A41E0FAA@netscape.net>
References: <200104240553.HAA01467@piglet.grunz.lu>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm not sure. The routers are cisco 55xx and 75xx with the latest firmware loaded. From there it hits the SprintLink and Abovenet clouds. I wish there was a tool that could do an point to point traceroute like journey and stop when it hits a hop that doesn't support ECN. Or does traceroute do this when used with 2.4 and ECN support on?

-jeramy b smith

mlan@cpu.lu wrote:
>
>
> Yup, that seems to be the problem. rsync works again for me on
> penguinppc. So I guess that some device close to penguinppc.org doesn't
> support ECN.....
>
--
-jeramy b smith


"Linux is Fun!" -Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
