Subject: Re: why is tty->pgrp set to -1 for console?
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OFA93F332E.5BEC00AC-ON86256B52.00699C5C-@86256B52.0069BC41LocalDomain>
From: "David Boutcher" <boutcher@us.ibm.com>
Date: Thu, 31 Jan 2002 13:14:54 -0600
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  We had a problem that ctrl-c was not working on the console.

You need to be running something like mingetty on the console to have
signals (like ctrl-c) picked up.  If you start Linux with something like
"init=/bin/bash" then job control signals (like control C and control Z)
won't work.

Dave Boutcher
iSeries Linux guy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
