Date: Mon, 12 Apr 1999 20:09:37 -0400 (EDT)
From: satadru pramanik <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ggi and frame buffer
Message-ID: <Pine.LNX.4.10.9904122007520.23848-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since linuxppc defaults to using a FB-device, ggi should work, right?  So
I compiled the latest snapshit, and when I tried to run a demo, ie
"cube3d" I got this:
cube3d: error in loading shared libraries: /usr/local/lib/libgg.so.0:
R_PPC_REL2
4 relocation out of range

Any clues to what this is?  Has anybody gotten libgii and libggi to work
successfully on LinuxPPC, especially pre-rel5?



----
satadru pramanik `satadru@umich.edu'
"Put your hand on a hot stove for a minute, and it seems like an hour. Sit
with a pretty girl for an hour, and it seems like a minute. THAT'S
relativity." 
-Albert Einstein
---


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
