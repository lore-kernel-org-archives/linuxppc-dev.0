From: kd@flaga.is
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <0025679B.003F3EB4.00@notes.flaga.is>
Date: Fri, 25 Jun 1999 11:30:47 +0000
Subject: Glibc 2.1 and MPC 8xx
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Thanks to Wolfgang Denk and Leif Lindholm regarding my problems with the
interrupt vectors.
I examined even better what was happening and it is probably a faulty
device driver causing the strange crasses.
At least the application is always running in the driver when it
crashes......... So a stupid user error 8-).

Anyway I am now trying to get the system to run on a self contained
Glibc2.1 system that will eventually be running from
flash. I have a lot of applications crassing all over. I believe it is due
to the cache size assumption made in Glibc2.1 that so many have mentioned
in the past few weeks. Does any one have a quick-hack-patch for fixing this
before I start to hack up a
code I do not understand the least 8-)? Are there any other known problems
with Glibc 2.1?

Thanks,

K.D.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
