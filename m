Message-Id: <200005031931.VAA17447@piglet.grunz.lu>
Date: Wed, 3 May 2000 21:31:04 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: hfs
To: scott@re-104-1.read.indiana.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10005031339350.32242-100000@fletch.read.indiana.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On   3 May, this message from Scott Knight echoed through cyberspace:
> 	Alright, so hfs isnt working. Is anyone out there working on it?
> Does anyone have any ideas as to why it stopped working in the first
> place? I know its not a showstopper but it would sure be nice. Ill
> probally try to look over stuff, but I dont know If ill be able to fix it,
> any and all help and info, or directions to discussions about the topic
> would be greatly apprecaited. Thanks.

I remember discussion on some mailing list about this stuff some time
ago, but when I looked recently, I didn't find anything.

Anyway, it seems the changes in the VFS code (the layer that unifies the
various filesystems towards the rest of the kernel) broke hfs. So that's
where you need to look...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
