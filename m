Message-ID: <3965CF90.B6457A0D@amulet.co.jp>
Date: Fri, 07 Jul 2000 21:39:44 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Drive Setup
References: <200007070846.JAA05142@hyperion.valhalla.net> <39659EB2.D4C095A6@amulet.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, update on Drive Setup:

I partitioned a stock iMac DV with 25GB drive using the "Preferred
LinuxPPC" scheme (which was surprisingly different from the "Preferred
MkLinux" and "Standard MkLinux" schemes). The Drive Setup version was
J1-1.8, which is a Japanese-localized 1.8 (it was on the Mac OS J1-8.6
CD which came with this iMac DV).

Here's what pdisk told me (YDL installed fine, as will any other
distribution that handles Apple partition maps):

All partitions were created with type Apple_UNIX_SVR2.

The names and sizes were as follows (I'm preserving the case):

(Apple_HFS       3.8G)

A/UX Root        4.7G
Swap             50M
Usr file system  4.7G
Opt file system  300M
Home file system 18.9G

The kernel (2.2.17pre9-ben1, but anything recent should be the same) had
no difficulty automatically finding the root partition on hda9. From
earlier experiments I know that the kernel does not just check the
partition name (so it wasn't fooled in this case either). It's worth
noting that root was the first Apple_UNIX_SVR2 partition; I know that
yaboot at least would have been confused by the capital S in "Swap".

It seems to me that while using the default setup may not be a good idea
(19GB /home??), Drive Setup does work fine for creating Linux
partitions. Perhaps renaming them to more standard Linux name would be a
good idea. (I don't have his card with me, but if anyone knows the Apple
employee who wrote Drive Setup please forward this and/or cc him on this
discussion.)

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
