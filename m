Message-ID: <36889B26.35B8C562@cybernex.net>
Date: Tue, 29 Dec 1998 09:04:38 +0000
From: John Droggitis <johnd@CYBERNEX.NET>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org, Cort Dougan <cort@ladron.cs.nmt.edu>,
        Paul Mackerras <paulus@cs.anu.edu.au>
Subject: Re: New patches & test kernel
References: <19981228180118.022846@mail.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> Hi All !
>
> I'm uploading a test kernel with new patches to my web page. It contains
> all diffs between this morning's vger and some of my latest patches. Not
> all or them are functional (wallstreet sleep still doesn't work and uses
> an horrible hack I made at the end of irq.c so you can avoid all irq.c
> and via-pmu.c patches).

A bit of a feedback here:  This is the first kernel EVER that I've booted
that recognizes my kensington orbit trackball as a three-button mouse.  The
left button acts as the left button, and the right one acts as middle.  And
for anyone using XF68, there's an option that lets you chord to emulate the
third button:  In XF86Config, in the "Pointer" section, on a line by itself
say: ChordMiddle.  To be honest, I just found this option and haven't tried
it yet, but for anyone with a two-button mouse this is worth a try.

--John


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
