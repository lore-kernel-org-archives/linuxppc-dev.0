Subject: Re: 2.4.13-pre5 crash when mounting proc
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	owner-linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Message-ID: <OF822FE6C3.5704E540-ON86256AEC.0058270C@rchland.ibm.com>
From: "David Boutcher" <boutcher@us.ibm.com>
Date: Sun, 21 Oct 2001 11:03:56 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> c0054448 t copy_mount_options
> c0054560 T do_mount
> c005471c T sys_mount

Hmm...the iSeries kernels in devel are failing the same way.  I was
assuming it was something I did (or didn't do) but now I'm thinking it's
more general.

Dave Boutcher
Senior Technical Staff Member
iSeries Linux Development and Architecture


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
