Date: Tue, 9 Oct 2001 20:33:08 +0200
From: Jure Menart <jure@kom.org>
To: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: linux + serial console
Message-ID: <20011009203308.B28132@hannanges.teden-mladih.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
I'm trying to have Linux box (custom made board, IBM 405gp), which would
'work' only through serial console (ttyS0).
I try many things but I just couldn't keep my 'console' on ttyS0.
I change everything in main.c to open only /dev/ttyS0, not the usual
/dev/console. I made /dev/std[io,out,err] links which pointed to /dev/ttyS0
(although it isn't important I think), but my console 'dissapears' anyway.
Did I forget something... or better - what did I forget?

Thanks in advance...Jure


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
