Date: Fri, 23 Jun 2000 03:55:34 -0400 (EDT)
From: "Jo-Ellen F. Mathews" <joellen@absoval.com>
To: Nguyen Xuan Hoang <hoang_nguyen@op.com.sg>
cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA
In-Reply-To: <01BF4D38.D23BB960@hoang.pacific.net.sg>
Message-ID: <Pine.LNX.3.96.1000623031857.11893A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 23 Dec 1999, Nguyen Xuan Hoang wrote:

>
> Hi All,
>
> I love this mail list, you are all very friendly... could anyone tell
> which PCMCIA device have worked with RPX Lite board I am interrest in
> Modem and HDD PCMCIA where can I find the driver... Yes, I have gone
> though the mail list but as Dan said we seldom hear from the people who
> are happy...

Greetings Hoang and list members,

I will certainly chime in with a happy story.  We do have our IEEE 802.11B
11Mbps wireless LAN PCMCIA device driver working on the RPX Lite (MPC823).
If anyone is attending the O'Reilly Open Source Software Convention (July
17-20, 2000), we'll be doing a wireless LAN tutorial based on our
linux-wlan Open Source project where we will demo the RPX Lite running as
a wireless device with an 11Mbps wireless LAN PCMCIA card in it.

This effort of successfully porting our linux-wlan driver to the RPX Lite
was because of the generous help of people on this list.  It wasn't easy,
and without the help of people on this list, we might still be banging our
heads against the wall.  :-)

I used Magnus Damm's PCMCIA code (that he so generously offered) and the
1.0 distribution of MontaVista's Hard Hat Linux.  I had to make two minor
changes to Magnus' code so it would work with 3.3 volt PCMCIA devices.
Additionally, there were a few edits to kernel source as directed by
Magnus. All of what I did is documented on our ftp site.

While I can't help you with device drivers for the PCMCIA devices you
mentioned, if you need a starting point for PCMCIA support, you're welcome
to download my notes and the files I used:

ftp://ftp.absoval.com/pub/rpxlite

We have moved our web site, and should anyone run into any trouble
accessing our web site or ftp site, e-mail me at 'jo-ellen@linux-wlan.com'
telling me which files you need.

>From someone who is VERY HAPPY (and may have 'accidentally' forgotten to
tell the list),
Jo-Ellen Mathews

---------------------------------------------------------
Jo-Ellen F. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
P.O. Box 941149            e-mail: jo-ellen@linux-wlan.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
