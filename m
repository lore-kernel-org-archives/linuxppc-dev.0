Message-ID: <20030506064428.74357.qmail@web9704.mail.yahoo.com>
Date: Mon, 5 May 2003 23:44:28 -0700 (PDT)
From: None Atall <linux_meis@yahoo.com>
Subject: Linux Kernel generic question (procedure queue)
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello everybody,
 Is it possible to insert
a specific procedure (among with it's args) to the
kernel scheduler? I know that we can just call
schedule(); when we wait for an asychronus input or
we can even insert an interrupt to the kernel queue,
but is it possible to queue a procedure?
 Just for understanding the problem better, I have
a function write_buff that calls write_byte.
Write_byte
function uses PPC gpio for implementing something like
an SPI interface. When we write a big file (e.x 1M),
the system will not respond to anything until the
transfer is done. I inserted "schedule();" every time
the write_byte is called so that the system will
accually perform some other tasks. So my question is
if I could insert write_byte function to the scheduler
queue in such a way to prevent this problem.

                           Thanks in advance
                                  Dimitrios.

=====
------------------------------------------------------------
-Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
 Greece.
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
