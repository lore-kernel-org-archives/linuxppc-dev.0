Message-Id: <200104242000.WAA00723@piglet.grunz.lu>
Date: Tue, 24 Apr 2001 22:00:31 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Rsync access through NAT?
To: geert@linux-m68k.org
Cc: ultrapenguin@netscape.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.10104242110570.2280-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Heya,

On  24 Apr, this message from Geert Uytterhoeven echoed through cyberspace:
> On Tue, 24 Apr 2001, jeramy b smith wrote:
>> I'm not sure. The routers are cisco 55xx and 75xx with the latest firmware loaded.

Fully Cisco on my end also... 803 as a NAT access-router at home, and
36xx devices from there on.

> From there it hits the SprintLink and Abovenet clouds. I wish there
was a tool that could do an point to point traceroute like journey and stop when it hits a hop that doesn't support ECN. Or does traceroute do this when used with 2.4 and ECN support on?
>
> I think it does.

No idea here... I'm new to ECN; I did some lookups at work today but
didn't have time to finish reading on it....

>> mlan@cpu.lu wrote:
>> > Yup, that seems to be the problem. rsync works again for me on
>> > penguinppc. So I guess that some device close to penguinppc.org doesn't
>> > support ECN.....
>
> Then why can I ping penguinppc.org without problems? Because my AXP firewall
> still runs 2.2.x?

Maybe because the NAT function on my Cisco 803 is to blame? Cisco might
'accidentaly' support it in normal packet forwarding, but might not when
doing NAT, since the IP header may need to be rewritten-- probably
without the ECN bits.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
