From: kd@flaga.is
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <0025677E.0039D96F.00@notes.flaga.is>
Date: Thu, 27 May 1999 10:31:52 +0000
Subject: Networking strangeness
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The solution was to enable the loopback interface (lo).

/sbin/ifconfig lo 127.0.0.1

Thanks go to  Chris and Leif.

K.D.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
