To: Grant Erickson <erick205@umn.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Solutions for Fast Software Upgrade in Linux/PPC
References: <Pine.SOL.4.20.0109251001370.4999-100000@garnet.tc.umn.edu>
From: Josh Huber <huber@alum.wpi.edu>
Date: Wed, 26 Sep 2001 11:51:17 -0400
In-Reply-To: <Pine.SOL.4.20.0109251001370.4999-100000@garnet.tc.umn.edu>
 (Grant Erickson's message of "Tue, 25 Sep 2001 10:38:15 -0500 (CDT)")
Message-ID: <87n13idk7e.fsf@mclinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Erickson <erick205@umn.edu> writes:

[snip]

I'd also recommend the fast-reboot option, but since no one mentioned
yet I'll suggest Werner Almsberger's bootimg utility.

Take a look at:
<URL:ftp://icaftp.epfl.ch/pub/people/almesber/misc/>

specifically, bootimg-current.tar.gz

Also, in ../booting/ there is a paper describing the
method. (bootinglinux-current.ps.gz)

I've tested this many times (we use it at Mission Critical for our
kernel crash dump system), and if you're looking for fast reboots this
is the way to go.

Unfortunately, it doesn't solve the upgrading of the ROM issue.

For the lazy who don't want to look at the references, what this
allows you to do is boot a linux kernel, using an already loaded Linux
kernel.

ttyl,
--
Josh Huber

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
