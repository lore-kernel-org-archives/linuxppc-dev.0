Mime-Version: 1.0
Message-Id: <v04210101b405cc106028@[192.168.0.1]>
In-Reply-To: <v03130302b40589d1f8f6@[17.202.21.235]>
References: <v04011701b404e6cd4493@[199.174.193.101]>
 <v04011701b404e6cd4493@[199.174.193.101]>
 <v03130302b40589d1f8f6@[17.202.21.235]>
Date: Wed, 15 Sep 1999 14:27:30 -0800
To: Peter Bierman <bierman@apple.com>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 15/9/99 Peter Bierman wrote:

>
>
>Since I'm the one that came up with the "disgusting kludge", do you have
>any ideas to share on how to make it better?

yes I have already mentioned it, do it like intel machines do, the 
BIOS (OF) loads code from the bootblock of the disk or root partition 
(marked bootable in the partition table), simple and filesystem 
independent.

requiring a dedicated partition for the BOOTSTRAP is ridiculous. 
and so is chaining oneself to a single filesystem (HFS)

the bootblock method works on most OF machines since there are plenty 
of people using quik to do it, its the newworld machines that are 
either different or broken, however they have a flashable ROM so 
apple can fix this oversight.



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
