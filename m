Date: Wed, 13 Jan 1999 14:07:04 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Gary Thomas <gdt@linuxppc.org>
cc: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>,
        linuxppc-dev@lists.linuxppc.org,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <XFMail.990113161857.gdt@linuxppc.org>
Message-ID: <Pine.LNX.3.96.990113140346.9777A-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Jan 1999, Gary Thomas wrote:

> > http://developer.apple.com/techpubs/hardware/hardware2.html
> 
> This document does not have enough detail to be able to make a port 
> for this hardware.  As far as I know, such details are only available
> directly from Apple under NDA until they decide to "leak" the info
> out, such as releasing ports, drivers, etc.

True, but some of the information is frequently available through other
means, like information available in MacsBug, especially where hardware
addresses are concerned.  It should be enough to at least get past the
interrupt hurdle (since I think the code's currently putting the interrupt
controller somewhere in the middle of either the ADB hardware or video
hardware (hence the monitor shutting off).  It's not as easy as working
with docs, but it's still (historically speaking, anyway) easier than
actually obtaining docs. ;-)


LATER,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624

-----BEGIN GEEK CODE BLOCK-----
Version 3.1
GCS/CC/FA/H/L/MC/M/MU/PA/TW d-@ s:>- a-- C++ ++>$ UBLAS*++ ++>$
P+?>$ L++ +>$ !E--- W++ +>$ N++(++ +)>++ +$ !o? K-? !w--- !O
M++>$ !V-- PS+>$ !PE- Y+>$ PGP+>$ t++ +>$ 5+>++ ++$ !X- !R tv+>$
b++>$ !DI !D- G++(++ +)>$ e>++ ++ h--! r--- !y-
------END GEEK CODE BLOCK------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
