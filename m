From: jlquinn@us.ibm.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <852568B0.00703001.00@D51MTA03.pok.ibm.com>
Date: Tue, 28 Mar 2000 15:25:31 -0500
Subject: readw byte sex?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've seen info about this go by in the past, but wasn't paying careful
attention...

I'm working on trying to get my Advansys 970UW working under PPC linux
2.2.x.  I'm not tackling 2.3.x because I don't think the driver itself is
up to date with respect to the 2.3 tree, while it is OK for x86 and alpha
2.2.x.  I'm having (surprise, surprise) byte swapping problems, which I so
far am tracing to the following construct and pals:

 x = le16_to_cpu(readw(addr))

Both of these are byteswapping, leaving me with a reversed value, which of
course causes havoc later.  What's the correct way to do this?  I can't
find where the exact platform-independent semantics of readw are defined.

Is this a FAQ?

Thanks,
Jerry Quinn


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
