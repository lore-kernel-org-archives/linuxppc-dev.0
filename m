Date: Thu, 23 Mar 2000 11:14:37 +1100
From: Chris Leishman <masklin@debian.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: PB2000 (pismo) install feedback
Message-ID: <20000323111437.A10858@freeonline.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

(I finally got yaboot configured (using a 100M bootstrap partition, hd:9), on
my pismo so I could test the pismo kernel.)

I compiled the kernel on a Lombard I have here, then moved the kernel
(vmlinux) onto my pismo bootstrap partition.  Initially yaboot.conf contained:

image=hd:9,vmlinux
	label=install
	initrd=hd:9,ramdisk.image.gz
	initrd-size=8192
	novideo

However, on booting the kernel, I had some very pretty errors with the video
(very, very surreal - looked like a CRT next to a big magnet).  However, when
I removed "novideo" flag it booted straight up!

Any ideas Ben & co?  Is this a known issue?

Regards,

Chris


--
----------------------------------------------------------------------
            Linux, because I'd like to *get there* today
----------------------------------------------------------------------
Reply with subject 'request key' for GPG public key.  KeyID 0xB4E24219

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
