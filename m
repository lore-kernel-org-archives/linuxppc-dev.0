Date: Wed, 2 Feb 2000 00:16:58 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: Alan Mimms <alan@packetengines.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Script for automated booting RPX boards
In-Reply-To: <0002011040160D.00776@alan.corp.packetengines.com>
Message-ID: <Pine.LNX.4.21.0002012224320.1229-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> Why not FLASH the kernel on your RPXLite and then autoboot it?  That works
> FINE for me.  (Always assuming that you're past kernel development and doing
> application work which changes on your target's NFS root mounted filesystem.)

Actually, I switch kernels quite often.
I also need to pass some parameters to the kernel, most often "ro" to make
sure that the production system will e.g. let me login with /dev/pty0
being on a read-only filesystem.

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
