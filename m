From: "Bob Piatek" <bobtek@fishcamp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: unresolved symbol
Date: Sun, 30 Dec 2001 17:02:43 -0800
Message-ID: <000001c19196$da8c6340$a2341204@P4>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

When attempting to load a module via 'insmod' I get the following:

insmod unresolved symbol kmalloc
insmod unresolved symbol unregister_chrdev
insmod unresolved symbol register_chrdev
...
insmod unresolved symbol printk


It seems that there was another person with the same problem on Sept 24,
2001 to this list.  However, the solution to the problem was not posted
to the list.

Can anyone give me some advice on where to look?

Bob Piatek

fishcamp engineering
105 W. Clark Ave
Orcutt, CA  93455
TEL: 805-937-6365
FAX: 805-937-6252


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
