Date: Thu, 6 Jul 2000 02:15:33 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE quirk
In-Reply-To: <Pine.LNX.4.21.0007052235430.3700-100000@gemini.home.net>
Message-ID: <Pine.LNX.4.21.0007060211240.6798-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 5 Jul 2000, Jamie Guinan wrote:

> I've been tinkering with the IDE drive on my MBX board.
<snip>
> Every other halfword does not "stick" on the drive.
<snip>

I guess the QSpan and/or WinBond likes having 32bit I/O thrown at it,

# hdparm -c 1 /dev/hda

This seems to have fixed my problem.  I fdisk'd and mke2fs'd and
everything looks peachy.

-Jamie


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
