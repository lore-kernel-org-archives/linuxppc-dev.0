Date: Mon, 7 Dec 1998 02:17:10 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: heavy scsi load crashes
Message-ID: <Pine.LNX.4.05.9812070213460.541-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have an adaptec 2940UW card hooked up to a IBM 8.5 Gb external hard
drive.  When I try to copy a file to it from the internal hard drive (2 Gb
scsi-2), I get a hard crash, and sometimes fail to reboot properly.
something about a scsi in queue, and the need to reboot in 180 seconds.
Any ideas on this?  This is not acceptable, and I want to do anything I
need to to fiix this.

7600/132 with 80 meg ram and 2.1.130


----
satadru pramanik `satadru@umich.edu'
"Put your hand on a hot stove for a minute, and it seems like an hour. Sit
with a pretty girl for an hour, and it seems like a minute. THAT'S
relativity." 
-Albert Einstein
---


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
