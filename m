Date: Wed, 27 Oct 1999 20:11:16 +0000 (   )
From: John Buswell <johnb@one.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: iMac DV and BootX
Message-ID: <Pine.LNX.3.96.991027200622.25681C-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hey,

I have a new iMac DV for a few days now and I've been trying to get it to
boot Linux. I think I have narrowed the problem down to something wrong
with BootX. Using BootX 1.2b (in debug mode), I get as far as Exiting
BootX! message, then it clears the screen, but does not produce the
booting... message, it just sits there with a nice blank screen while
still remaining powered up. I had someone try this on an iMac Rev.B and it
produces lots of debug information after the booting.

Does anyone have any ideas why? (or better still, someone with a better
idea of how bootX works that might have some suggestions).

There is a PICT screen shot of the last screen in BootX before the blank
screen, available from:

ftp.one.net/pub/users/johnb/screenshot.gz

there is also a file there called imacdv.tgz with a complete dump from
name display registry.. 

i'm hoping to get this working soon as i need the imac booting for a
college project :)

thanks

John Buswell
4th Year IT&T Student
University of Limerick


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
