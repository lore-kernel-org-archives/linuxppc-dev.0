From: bskrypny@MBnet.MB.CA
Message-Id: <v01540b02b37673433b9a@[192.168.100.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 29 May 1999 21:53:52 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: cuda and apm?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After looking at via-cuda.c file and some other sources I have a few questions:

1. Does via-cuda currently handle only adb requests or are other requests
hidden in adb_request structure?
2. Are there any Mac ROM routines that can be accessed to deal with cuda
controller?
3. What are apm plans for linuxppc.
4. Where can I find technical description of cuda controller (I know at
Apple, but I couldn't find anything better than a general description and a
cursory mention in the context of PowerManager API ).

I hope to do some work for apm (to get my feet wet :)

Bill.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
