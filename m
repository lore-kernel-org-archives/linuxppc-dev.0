Message-ID: <010201c447e2$e173cc20$3cc8a8c0@epro.dom>
From: "Colin LEROY" <colin@colino.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: write stuff in the PRAM?
Date: Tue, 1 Jun 2004 16:15:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm trying to get TV-out work on my iBook G4.
After booting with a CRT attached, I get
$ cat /proc/device-tree/pci@f0000000/ATY,ViaParent@10/ATY,Via_B@1/display-type
CRT

I get the same after booting with a TV attached.

It looks like setting this to "STV" would make TV video-out work (or at least
help it work ;-).

Is there any way to do such a thing (either a tool, a kernel patch, or in
openfirmware voodoo) ?

Thanks,
--
Colin
  This message represents the official view of the voices
  in my head.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
