Date: Wed, 8 Nov 2000 21:42:45 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: how to pass kernel command line arguments?
Message-ID: <20001108214245.A31388@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

Okay I shall be more specific, how do I pass kernel command line arguments
(say for example a video=whatever) to the kernel when booting the kernel on
the hfs floppy disk image that comes with debian potato. Does anyone know?

The debian install manual does not mnention what mechanism the floppy uses
to boot, however it is a normal mac like

[21:40:04] 5 innuendo root /mnt/floppy>ls -la
total 1203
drwx--x--x   4 root     root            9 Nov  8 21:17 ./
drwxr-xr-x   4 root     root         1024 Oct  9  1998 ../
dr-x--x--x   2 root     root            9 Nov  8 21:17 .finderinfo/
dr-x--x--x   2 root     root            9 Nov  8 21:17 .resource/
-rw-------   1 root     root          300 Nov  8 21:17 .rootinfo
-rwx--x--x   1 root     root            0 Jul 25 11:45 Finder*
-rwx--x--x   1 root     root            0 Apr  7  2000 System*
-rwx--x--x   1 root     root       268171 Jul 25 11:52 System.map*
-rwx--x--x   1 root     root       961719 Nov  8 21:17 zImage*

I suspect the .rootinfo may have something to do with the bootup for linux,
though not sure and I dont know where to find docs on this stuff either.

Thanks

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
