Date: Mon, 5 Jun 2000 17:37:31 -0400
Message-Id: <200006052137.RAA29282@rome.wavemark.com>
From: Kent Borg <kentborg@wavemark.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Running from ROM
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am doing some early investigation of the suitability of embedded
Linux.  I am wondering about program loading.

Traditionally, embedded systems run their programming directly out of
ROM.  Linux doesn't seem to have any concept of such a thing.  But if
I have a large embedded application that needs every bit of its RAM
and ROM, I would like to find a way to get Linux to run directly out
of ROM with no moving parts (no disks).  Anyone doing that?


Thanks,

-kb, the Kent who has done some web searching and is close to
concluding no one is doing this, but he hopes he is wrong.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
