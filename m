Message-Id: <200102221524.f1MFO2709134@ashley.ivey.uwo.ca>
Date: Thu, 22 Feb 2001 10:24:01 -0500
Reply-To: khendricks@ivey.uwo.ca
Content-Type: text/plain;
	charset=us-ascii
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0 (Apple Message framework v337)
Subject: do md5sums differ across architectures? 
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I ran md5sum on a big bz2 archive on my ppc linux box and then
ftp'd it to my Sun Solaris 7 box at work.

I checked it with md5sum on that machine and it differed.

Okay I thought, a bad packet during upload.

So I tried again, same result.

I then passed back and forth (known good archives) and the md5sums
were different.

Okay, I thought maybe an endian issue but both Solaris Sparc and PPC
Linux are big endian.

Should these sums be different?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
