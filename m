Return-Path: <bwarren@qstreams.com>
Received: from web314.biz.mail.mud.yahoo.com (web314.biz.mail.mud.yahoo.com
	[68.142.199.14]) by ozlabs.org (Postfix) with SMTP id B6875DE007
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jun 2007 00:51:43 +1000 (EST)
Date: Fri, 1 Jun 2007 07:51:35 -0700 (PDT)
From: Ben Warren <bwarren@qstreams.com>
Subject: RE: Kernel 2.6, ML403, rootfs on nfs, gigabit ethernet link,
	nfs mount problems
To: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
In-Reply-To: <BAY115-W17F1AB35DDD5B358CAC89B22D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <951481.72146.qm@web314.biz.mail.mud.yahoo.com>
Cc: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--- Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:

> 
> Hi all,
> 
> thanks for suggestions
> I added rsize=1024,wsize=1024 to CMD LINE. INIT can now be executed from nfs,
> but I think that the problem still exists,
> during the start up process ( from when the rootfs is mounted until user get
> a command prompt ) some times ML403 stops working completely, and generates
> "Segmentation Fault" and similar messages. some other times the system comes
> up with no problem. 
> 
> I had the same problem when mounting rootfs using nfs via 100mbits link , but
> for gigabit link the probability of reaching this unstable state is much
> higher.
> 
> any ideas?
> 

Sorry, I don't know anything about your hardware.  Stating the obvious,
something's being put where it shouldn't be, maybe because the Ethernet driver
is filling buffers faster than they are being processed?  This is of course
stressed with a higher speed link.  You'll have much more control over your
debugging if you put rootfs somewhere other than NFS (flash or ramdisk), then
mount remote drives and try various file operations.

regards,
Ben
