To: "Navin Boppuri" <navin.boppuri@newisys.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Flash Driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Aug 2001 14:40:28 CDT."
             <3A494DE356A49A40B37442E1E0D9F3B506341D@ptah.ad.newisys.com>
Date: Tue, 14 Aug 2001 21:54:51 +0200
Message-Id: <20010814195456.248D610CBA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A494DE356A49A40B37442E1E0D9F3B506341D@ptah.ad.newisys.com> you wrote:
>
> Can I have the dd commands once again? I am not using busybox stuff.

dd if=some_file of=/dev/flashXY bs=ZZZk conv=sync

whith:

X = 'a' for the first, 'b' for the second flash bank, etc.
Y = number of the flash partition (1 = 1st, 2 = 2nd, etc.)

ZZZ = your erase block size

For instance, I can use

	dd if=/tmp/ppcboot.bin of=/dev/flasha1 bs=128k conv=sync

to write a new PPCboot image to soem of our boards.

Be careful - /dev/flasha is the full 1st flash bank  (unpartitioned).
The devices names are similar to those of harddisks.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Remember, there's a big difference between kneeling down and  bending
over.                                                   - Frank Zappa

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
