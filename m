Date: Fri, 10 Aug 2001 14:47:14 -0700
Subject: 1 GigaByte memory problem on BriQ (memory limits?)
From: Karsten Jeppesen <kj-list@jeppesens.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B799A471.A093%kj-list@jeppesens.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Any comments on this here is greatly appreciated:

I am having trouble with Linux accepting 1G memory.
512M works fine, but at 1G Linux gets all the way through the initialization
until the partition check.

At this point Linux (checking hda) reports:
Unable to handle kernel NULL pointer at virtual address 000)

And then the registerdump.

Before I send all the other debug output I would like to know if anybody
knows of any memory limits in Linux?
I don't see any compile switches (which is good).
Currently running 2.2.19 kernel.org kernel added support for the BriQ. I am
not done porting the 2.4.x kernel yet - sorry for that.



Sincerely,

Dr. Karsten Jeppesen
VP of Technology
Total Impact
<kj@totalimpact.com>
----------------------------------------------------------------------
There's so much plastic in this culture that vinyl leopard skin is
becoming an endangered synthetic.
----------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
