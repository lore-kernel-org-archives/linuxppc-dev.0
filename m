To: Pavel Roskin <proski@gnu.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux-2.4.0-test4 - problems in memory management? 
In-reply-to: Your message of "Tue, 18 Jul 2000 20:15:22 -0400"
             <Pine.LNX.4.21.0007182007220.6653-100000@sunapee.transcept.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Jul 2000 11:49:20 +1000
Message-ID: <17738.963971360@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 18 Jul 2000 20:15:22 -0400 (EDT), Pavel Roskin <proski@gnu.org> writes:
>After going all the way down from fread() to __copy_tofrom_user() it
>appears that the later is at fault. It fails to copy large amounts of data
>(216 bytes is enough to be a problem) to the pages that have just been
>mmap'ed.

Hi Pavel, check out the thread "Help with string.S" in the linuxppc-dev
mailing list - it begins with this message:

http://lists.linuxppc.org/listarcs/linuxppc-dev/200007/msg00155.html

In particular, check out this message:

http://lists.linuxppc.org/listarcs/linuxppc-dev/200007/msg00153.html

Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
