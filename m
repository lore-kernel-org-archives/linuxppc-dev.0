Date: Mon, 6 Dec 1999 08:34:46 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Voodoo3/Banshee test kernel...
Message-ID: <Pine.LNX.4.10.9912060825590.22702-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i've placed a test kernel with the development voodoo3/banshee driver at

	ftp://devel.linuxppc.org/users/ajoshi/voodoo/vmlinux-120699.bz2

if any voodoo3 users could try this kernel and tell me if they can get a
console that would be great, as i only have a Banshee GameRocket to test
it on.

notes:
o the default mode is 640x480 8bpp 60Hz, i'll add user user mode selecting
once all the modes are working properly.
o its unacellerated for now

sorry, i forgot the .config
i tried adding as many scsi/ide drivers as i thought necessary but if your
scsi-8ultramonster driver isn't in there, then sorry.



ani

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
