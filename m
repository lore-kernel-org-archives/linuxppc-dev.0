Message-Id: <199904281926.VAA01978@student.physik.uni-mainz.de>
To: Paul.Mackerras@cs.anu.edu.au
Subject: Re: Endianess problems in linuxppc kernel
Cc: linuxppc-dev@lists.linuxppc.org
Date: Wed, 28 Apr 1999 21:23:45 CEST
From: "Christian Bauer" <Christian.Bauer@uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Reply-To: Christian.Bauer@uni-mainz.de
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

>[sound]
>Is the application perhaps using AFMT_S16_NE (native endianness) but
>assuming that that means little-endian?

This seems to be the case. I've written a test program that uses AFMT_S16_NE
and writes big-endian data and that works. So the bug appears to be in esd,
because the GNOME sounds are also affected.

Bye,
Christian

-- 
  / Coding on PowerPC and proud of it
\/ http://www.uni-mainz.de/~bauec002/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
