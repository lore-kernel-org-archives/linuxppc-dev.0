Message-ID: <001f01c0717c$58183a00$4a1f76d8@washington>
From: "Navin Boppuri" <nboppuri@trinetcommunication.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Neighbour Table Overflow on NFS Server
Date: Fri, 29 Dec 2000 09:47:23 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

Thank you very much for all your replies. From all the answers, I can
understand that there can be two main reasons,

   1) The connection to the server is messy due to either physical
connectivity issues or server issues
   2) Ethernet driver is messy.

Taking into account the first problem, I tried changing ethernet cables, hub
etc. but it did not help. The network is working just fine. We are able to
connect to the Internet, and to other machines in our network. Everything
else works fine. The funny thing is that I do a tftp of the zImage and that
part of it works just fine. It seems to be the NFS Server that fails. Now, I
did not change any settings in the NFS server from the last time it worked,
which was just a day back.

The strangest thing is that none of the NFS Server's I tried setting up on
my other linux machines seem to be working.

I am sure the ethernet driver is fine since the tftp works just fine. It's
been doing well from quite some time.

With all these factors, it has become very difficult to pinpoint to a
particular cause of failure. I am in the process of testing an important
driver till this popped up.

Thank you,
Navin Boppuri


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
