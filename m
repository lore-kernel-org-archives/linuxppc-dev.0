Message-ID: <3825AFBB.C0C30D4@schweiz.ch>
Date: Sun, 07 Nov 1999 17:58:47 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
Reply-To: a.tobler@schweiz.ch
MIME-Version: 1.0
To: Wolfgang Haeuptli <whaeuptli@bluewin.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: scanner not recognized (interrupt in idle phase?)
References: <99110714573501.00535@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Wolfgang Haeuptli wrote:
> 
> Hello,
> 
> on startup, I see this message (mesh: interrupt in idle phase?) while the system
> checks the scsi bus. This is on a kernel 2.2.9 with sg-driver included, on a
> performa 6400 with a UMAX Astra 1200S scanner (which works on the MacOS
> side, b.t.w.).
> 
> Any scsi-crack around that could give me a pointer how to solve the problem?
> (Do I need another low-level driver for my scsi-chip ... which would be what??)
> 

Have you tried a stock kernel 2.2.13 from ftp.xy.kernel.org (xy for your
prefered domain ,ch ,de, uk...)
I have no scanner but I noticed the following page which refers to a
'new' sg driver. This driver should be in since 2.2.6. www.torque.net/sg.
Maybe this is a hint...

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
