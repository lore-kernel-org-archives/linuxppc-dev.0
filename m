Date: Thu, 9 Dec 1999 10:51:41 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PowerPC 4xx Patches vs. 2.3.31 Available
Message-ID: <Pine.SGI.4.10.9912091037340.158405-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've posted my latest set of patches for the PowerPC 4xx against the
2.3.31 kernel at

	http://www.lcse.umn.edu/~grant/Linux/index.html

along with a bit of status and "to-do" information.

The kernel should most definitely compile and link. However, you must be
sure that you configure INITRD to "off" as it doesn't appear to work in
the 2.3 kernels yet.

As always with highly-experimental development stuff, this isn't for the
faint of heart. But if you've got a good hardware single-step debugger, a
PowerPC 4XX Developer's Manual, and some time, dive in!

Regards,

Grant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
