Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <m.venkatraj@exgate.tek.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ADS860 - unable to load kernel- Bad magic number
Date: Fri, 27 Feb 2004 12:45:13 +0800
Message-ID: <001601c3fcec$7d5500b0$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <301A812E6528D511A8F70008C71E578601FCF4F6@ap-bang-m02.india.tek.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(1) you can seenv verify=n, then boot image. if it is OK, then the
length of image when you burned into flash is short for several bytes.

(2) you'd better take a look at doc of www.denx.de/...

good luck for you!

-----Original Message-----
From: m.venkatraj@exgate.tek.com
Sent: Friday, February 27, 2004 12:35 PM
Subject: ADS860 - unable to load kernel- Bad magic number

I am a linux-newbie working on a parallel track on the MPC 860, on a ADS
board. I am facing difficulty in getting the kernel to load. This is
what I have done so far:

- built a cross-toolchain using Dan Kegel's crosstool.
- built u-boot-1.0.1 and flashed it to the board using BDI2000
- built linus-2.4.22, (with the below mentioned patch on last attempt).

The compilation goes through fine, I get "vmlinux" on the top-dir, and
also a vmlinux.gz in the arch/ppc/boot/images if I do a "make zImage".

When I configure bootp, and bootup the board, u-boot comes up fine, the
tftp download of the kernel image goes through fine too. Then I am stuck
with a "Bad Magic Number". Some initial digup led me to a mismatched
image header magic number.

Could anyone please help me with how to go ahead? Am I missing
something?

Also thanks to everyone whose postings on this and other lists helped me
get started!

-----Original Message-----
From: Xavier Miville [mailto:xmiville@oerlikon.ca]
Sent: Thursday, February 26, 2004 9:58 PM
Subject: RE: PCI daughter card with USB on a 405GP

You will need to apply the corresponding linuxppc patch
(/pub/linux/kernel/ports/ppc/2.4) to 2.4.22. The zvmlinux doesn't seem
to be built with only 2.4.22.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
