Message-ID: <407527E2.6040207@246tNt.com>
Date: Thu, 08 Apr 2004 12:22:26 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patch for Linux 2.6 on MPC5xxx
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is basic support for the MPC5xxx on the 2.6 series :

 * The patch can be obtained at :
http://www.246tNt.com/linux-2.5-mpc5xxx-20040408.diff.bz2

It applies to a tree constructed by a
bk clone bk://linux.bkbits.net/linux-2.5
bk pull bk://source.mvista.com/linux-2.5-ocp


 * There is also a read-only bitkeeper tree at
bk://bkbits.246tNt.com/linux-2.5-mpc5xxx

Please, try to avoid cloning it directly since the BW is limited on this
server. Prefer a :
bk clone bk://linux.bkbits.net/linux-2.5
bk pull bk://source.mvista.com/linux-2.5-ocp
bk pull bk://bkbits.246tNt.com/linux-2.5-mpc5xxx

which should give the same result.


There is a Documentation/powerpc/mpc5xxx.txt file for more informations.

Any comments, feed-backs, patches, whatever, are welcomed ;)


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
