From: "Michael Fischer" <fischi@epygi.de>
To: <acurtis@onz.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Debugging Network Performance
Date: Tue, 4 Jun 2002 17:05:41 +0200
Message-ID: <OEEHJMIIDJHHMFGGDNGDEEEOCOAA.fischi@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEBLDIAA.acurtis@onz.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
> Any idea who the network stack maintainer is? Perhaps they have something
> that timestamps a packets progress through the pipeline.

i dont know about what/if they are using but when i had to do something
similar i patched my kernlel with the LTT package
(http://www.opersys.com/LTT/). They have some built in tracepoints which are
usefull + added some user defined trace events at different points within
the driver and the stack. With a sequence number in the package which is
copied to the trace you can pretty much follow and timestamp the way of the
packet through the system.
Of cause this is affecting the performance a bit but it may give you some
idea where the packet spents most of the time.

Best regards, Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
