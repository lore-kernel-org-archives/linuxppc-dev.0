Subject: Re: current linuxppc_2_4_devel SMP strangeness.. (processes dieing)
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF0228CE16.DE2672A5-ON86256AF5.00673D53@rchland.ibm.com>
From: "David Boutcher" <boutcher@us.ibm.com>
Date: Tue, 30 Oct 2001 12:50:14 -0600
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I am 'reliably' able to reproduce the following:
>
> kalmia:/var/log# /etc/init.d/squid restart
> Restarting proxy server:
> /etc/init.d/squid: line 3:   450 Segmentation fault
start-stop-daemon

Me too.  Same symptoms on iSeries.   There were some memory related changes
that went in today...I suspect the problems are related to that.

Dave Boutcher
Senior Technical Staff Member
iSeries Linux Development and Architecture


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
