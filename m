Message-ID: <67505026E29DD311A9AA00508B7315F350A513@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'jari.nguyen@serialsystem.com.sg'" <jari.nguyen@serialsystem.com.sg>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Ram Disk
Date: Wed, 20 Sep 2000 08:58:37 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
Hi Jari,
Maybe you were talking to Jacob? Hmmm.
I have posted this already. Look at 8/24. But here you go and feel free to
post it again if you like.
Thanks,
Julia

>From John's note my code change was as follows:
I moved a close comment down 5 lines.

lines 405 - 409 commented out in linux/mm/vmscan.c

/* Then, try to page stuff out..
		while (swap_out(priority, gfp_mask)) {
			if (!--count)
				goto done;
		}
*/

John wrote:

In *my* code (I am running a modified 2.2.15 kernel), I merely commented out
the "swap_out ()" code in routine do_try_to_free_pages in mm/vmscan.c (in my
code, it's lines 405-409).  Since I made this change, my system has been
rock-steady (and I run a LOT of applications, including the Apache web
server and various CGI scripts I have written).  I now see free memory go
down as new images are read from the ramdisk, and back up as memory is freed
by the system.
Hope this helps your problem...
John Whitney


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
