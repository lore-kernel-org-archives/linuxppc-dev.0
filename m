Message-ID: <1180.80.7.99.14.1077956583.squirrel@www.solinno.co.uk>
Date: Sat, 28 Feb 2004 08:23:03 -0000 (GMT)
Subject: Please revert "use todc time functions for PPC_PREP" changeset
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom,

Your patch (ChangeSet@1.1557.41.25) breaks the 43p140 and Carolina, and
probably quite a few other RS/6000 based PRePs.  I was a bit surprised
to see it 2.6.3.

http://linux.bkbits.net:8080/linux-2.5/patch@1.1557.41.25?nav=index.html|ChangeSet@-3w|cset@1.1557.41.25

Can we revert this until there is a working version, please?  I don't
really know enough about this stuff to fix it myself, unfortunately,
although I'm working through the code to see how it works.

Cheers,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
