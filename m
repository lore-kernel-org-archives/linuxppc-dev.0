To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: "Walser, Martin" <mwalser@harris.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: unable to uncompess kernel image 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Feb 2002 15:52:24 GMT."
             <3C5FFFB8.5000409@cambridgebroadband.com>
Date: Tue, 05 Feb 2002 17:58:30 +0100
Message-Id: <20020205165835.AD017116B8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C5FFFB8.5000409@cambridgebroadband.com> you wrote:
>
> I'm a little bit confused as to whether you are trying to build a ramdisk image or a kernel image.

Well, as I understood he tried to combine both  the  kernel  and  the
ramdisk images in one file; this is sometimes useful when you want to
deal with a single file only (like when booting from a boot server).

In PPCBoot terminology this is called a "multi-file image":


	$ mkimage -A ppc -O Linux -T multi -C gzip \
	-n 'Linux Multiboot-Image' -e 0 -a 0 \
	-d vmlinux.gz:ramdisk_image.gz pMulti


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A man either lives life as it happens to him, meets  it  head-on  and
licks it, or he turns his back on it and starts to wither away.
	-- Dr. Boyce, "The Menagerie" ("The Cage"), stardate unknown

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
