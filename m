Message-ID: <20021103050239.5614.qmail@kunk.jriver.com>
Subject: 601 and benh kernels??
To: linuxxppc-dev@lists.linuxppc.org
Date: Sat, 2 Nov 2002 23:01:09 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was having a load of trouble on a 7200 (w/601) running as an AMPR
internet gateway on debian woody and finally discovered that if I
used Bens 2.4.20-pre1 kernel as opposed to the debian 2.4.18 kernel
the trouble went away.  (It's using adaptec 2940 and fireport 40
(symbios) scsi controllers as well as a tulip card, I was geting
random resets/timeouts on the fireport 40).

What I'm wondering is: what is the state of the mysterious 601 fixes?
They have at times been a choosable option in the config but
the option was gone in the 2.4.20-pre1 kernel config. Are these
fixes in some kernels and not others?

Thanks,
Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
