Message-ID: <20040302000732.79306.qmail@web21103.mail.yahoo.com>
Date: Mon, 1 Mar 2004 16:07:32 -0800 (PST)
From: Lou Rickard <lou_rickard@yahoo.com>
Subject: ml300 system init very slow
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks to people on the list, I finally got the ml300
booting on it's own filesystem.  Thank you.

And of course, another question.  After kernel boot is
done, the system begins intialization, but it goes
REALLY slow.

It gets to the:
"Freeing unused kernel memory: 64k init"
line just fine, but from that point, it takes about
five minutes to finish coming up and  providing a
login prompt.

>From the following lines:
"INIT: version 2.78 booting
INIT: Entering runlevel: 3
Entering non-interactive startup"
and on it's just super slow.

At a certain point it starts inetd and telnet
services, so I can acually telnet into the box and
everything in that session seems nice an perky, just
like normal, but everything over the serial line is
slower than molasses.  This is both over the NFS mount
and using the flash file system.

Any ideas?

Thanks,

~lr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
