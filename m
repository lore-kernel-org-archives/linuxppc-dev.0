Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Mark Wisner" <markwiz@us.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Debugging Network Performance
Date: Tue, 4 Jun 2002 06:30:16 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFIEBKDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <OFA5A51CBB.95D864D5-ON85256BCE.003C5665@raleigh.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Netperf can give you a vary detailed report about network performance. If
> you think your problem is related to network hardware problems,
> look at the
> errors listed in "ifconfig". This should tell you if you are getting bad
> packets or dropping packets.

I did fix a problem in the driver and now there are no error reported by
ifconfig.

> If you think it is a kernel problem some benchmarks may help you narrow
> down the problem. Networks are pretty fluid and sometimes hard to get
> reproducible results. When I try to determine driver/kernel network
> perfomance I try to use an isolated network where I have control over all
> traffic or I use test hardware such as IXIA or Smartbits.

All testing is done on an isolated network. I do not believe that the
problem is in the driver itself. The driver has not changed significantly. I
do need to check the error path since it appears that errors actually help
performance.

What is the best way to track packet processing through the kernel?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
