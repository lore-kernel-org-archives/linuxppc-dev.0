Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Mark Wisner" <markwiz@us.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Debugging Network Performance
Date: Tue, 4 Jun 2002 07:46:39 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEBLDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <OF93B8F461.B08FA3A3-ON85256BCE.004FA168@raleigh.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> KGDB may be a good start. netif_rx() is where the packet gets
> passed to the
> stack. It basically throws the packet on a linklist for ip_rcv() in
> ip_input.c to pick up and start processing it through the stack until it
> passes the results to the application. This is tough stuff. Let
> me know how
> you make out.

Any idea who the network stack maintainer is? Perhaps they have something
that timestamps a packets progress through the pipeline.

> I would guess the IP stack has not changed much between kernels.
> I would be
> more concerned about how the scheduler is working and other kernel tasks.

The system is basically idle except for the NFS/FTP traffic.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
