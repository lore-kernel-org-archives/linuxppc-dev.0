Date: Mon, 24 May 1999 01:11:03 -0600 (MDT)
From: Brad Midgley <brad@turbolinux.com>
Reply-To: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: CDROM driver flakiness
Message-ID: <Pine.LNX.3.95.990519114826.18017A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi-

i have seen a problem with the cdrom driver in linux. under linux, reading
a file from a cd dies with an i/o error but under macos the file can be
retrieved. why? what is linux doing differently? does macos retry the read
more times? 

i've seen this with a 7500's 4x apple cdrom drive and both regular and
cd-r disks.

Brad
brad@pht.com | http://www.pht.com/~brad/




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
