Message-ID: <38968743.2DA6D666@netx4.com>
Date: Tue, 01 Feb 2000 02:12:03 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Lachlan Audas <laudas@transport.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Looking for cllf-2.2.13.tgz
References: <38960E11.6F73E8C1@transport.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lachlan Audas wrote:


> I was looking the for the linux kernal cllf-2.2.13.tgz on


Use linuxplanet-2.2.13.tgz.  This is complete for all RPX boards
and other 8xx boards.  For the CLLF, configure for RPX Classic,
860T, no PCI, Ethernet on SCC1 and FEC.  Don't enable any
serial driver/console stuff (or most anything else :-).

After some announcements this week at Linux World, these
kernels (among many other tools) will find a new home on some
better server.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
