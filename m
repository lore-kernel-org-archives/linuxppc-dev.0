From: Wolfgang Haeuptli <whaeuptli@bluewin.ch>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Need testers with MESH SCSI
Date: Fri, 22 Dec 2000 17:00:28 -0500
Content-Type: text/plain
References: <200012220559.XAA11090@lists.linuxppc.org>
In-Reply-To: <200012220559.XAA11090@lists.linuxppc.org>
MIME-Version: 1.0
Message-Id: <00122217123800.00661@lobo.localnet>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, would have been a nice christmas present... BUT STILL:
(after applying the new mesh_init() to scsi/mesh.c)

mesh: target 6 aborted

which means that my UMAX Astra 1200S Scanner still does not work under
linuxppc...

My System: Performa 6400, Kernel 2.2.15pre19

(a couple of months ago I found a message on the list how to enable
scsi-debugging/logging, which magically made the scanner work -- slow and lots
of debugs in log/messages. There must be a better way...)

Greetings

Wolfgang Haeuptli

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
