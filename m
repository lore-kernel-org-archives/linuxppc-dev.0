Date: Fri, 7 Apr 2000 11:20:52 -0400 (EDT)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Software Emulation Exception...
In-Reply-To: <200004071354.JAA03494@hoover.gilbarco.com>
Message-ID: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Jason!

> I was hoping you all would pass some knowledge on to me.  Occasionally our
> application dies and our board goes into a loop of printing
>
> "Software Emulation %s/%d NIP: %lx *NIP: 0x%x code: %x"

This happened to me when I tried to read more than 8 megabytes of data
from ATA Flash inthe same time by using e.g.

dd if=/dev/hda of=/dev/null count=17000

The problem has gone after upgrading to the Montavista kernel (from their
CDK 1.0)

However, I have no idea what caused the problem and whether it has been
fixed.

By the way, I found a newer kernel (March, 23) in
ftp://ftp.mvista.com/pub/CDK/updates/1.0/ppc_8xx/SRPMS/

I haven't tested it yet.

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
