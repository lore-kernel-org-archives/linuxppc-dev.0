Date: Mon, 19 Jul 1999 15:41:59 -0600 (MDT)
From: Brad Midgley <brad@pht.com>
To: Hartmut Koptein <Hartmut.Koptein@t-online.de>
cc: Matt Porter <mmporter@home.com>, VALETTE Eric <valette@crf.canon.fr>,
        linuxppc-dev@lists.linuxppc.org
Subject: cdrecord (Re: Is the vger 2.2 kernel branch dead)
In-Reply-To: <19990719230733.X25323@isis.isis.de>
Message-ID: <Pine.LNX.3.95.990719153617.1369A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on the topic of cdrecord, i found i can burn to CDRW media but not CDRs
(it dies with "retryable errors" when closing the CDR)  this is on a
7500's external bus with paul's 2.2.10 and a ricoh MP6201S firmware 2.20
using Cdrecord release 1.8a22. has anyone else seen this?

> #define SHMMAX 0x1000000                /* max shared seg size (bytes) */

this one can be fixed in userspace. in /etc/rc.d/rc.sysinit:

# set shmmax to allow cdrecord to work
echo 6000000 >/proc/sys/kernel/shmmax

Brad
brad@pht.com | http://www.pht.com/~brad/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
