Message-ID: <369D7A76.1FF003@cs.adelaide.edu.au>
Date: Thu, 14 Jan 1999 15:32:46 +1030
From: Duncan Grove <duncan@cs.adelaide.edu.au>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: modify /usr/include/signum.h
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


someone needs to add #define SIGCLD    SIGCHLD to /usr/include/signum.h

btw, why are so many of the /include/*.h files (esp. tcp code) so
screwed? -- Why/how were they messed up for the PPC release from the
original Redhat 5.2 distribution?

--
Duncan Grove
+61 8 8303 6166
duncan@cs.adelaide.edu.au
You broke the bonds
You loosed the chains
You carried the cross <><



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
