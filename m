Date: Wed, 4 Oct 2000 12:17:39 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: Daniel Furse <daniel.furse@iptest.com>
cc: "Linux Embedded List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MBX860 Linux 
In-Reply-To: <0D9416AE7F95D411A8710008C7332F3F0DEA@GUILDFORD4_NT>
Message-ID: <Pine.LNX.4.21.0010041204500.7415-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 4 Oct 2000, Daniel Furse wrote:

> Hi all,
>
> Can anyone recommend a real-time embedded linux version for the MBX860
> board?
>
> I am evaluating alternatives, but the only option I have so far found
> is the MontaVista Hard Hat linux with their Real-Time Scheduler.

Is there a problem with this one?  Hard Hat worked great for me on an
MBX821.

I used CDK 1.0 which includes hhl-ppc_8xx-kernel-2.2.13-3.noarch.rpm.
I didn't have any hard realtime requirements, so I didn't bother to
look at the realtime stuff (I believe that's in a separate patch anyway).

The newer CDK 1.2 even comes with vi and other goodies - I can't
see any reason not to use Hard Hat.

The only problem I had with the MBX was the lack of schematics (maybe
someone at Motorola actually has them, but I was not able to locate
that person).  If you're considering buying new boards, you might look
at the Embedded Planet boards.

-Jamie


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
