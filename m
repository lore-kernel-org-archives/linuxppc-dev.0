Date: Mon, 4 Oct 1999 11:58:48 -0400 (EDT)
From: Elliot Lee <sopwith@redhat.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
In-Reply-To: <Pine.GSO.4.10.9910040826360.15704-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.9910041156210.15818-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 4 Oct 1999, Geert Uytterhoeven wrote:

> There are different sound format codes for little and big endian 16
> bit sound. Look at the sound headers.

That isn't the problem here. Apparently someone put a bad hack into the
PPC sound driver that makes it default to little endian instead of big
endian format, and esound is expecting that "native endian" on the sound
device is "big endian", not "little endian".

-- Elliot					http://developer.gnome.org/
The first thing a programmer needs to admit is that any program is by far
more complex than his own mind. Thats why he partitions it into neat
pieces and avoids complexity.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
