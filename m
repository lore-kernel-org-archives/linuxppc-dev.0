Return-Path: <xma@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 040BD67A65
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 04:49:32 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k49InUC6020044
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 14:49:30 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k49InUUi251218
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 12:49:30 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k49InTwb002114
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 12:49:30 -0600
In-Reply-To: <20060509184451.GF22825@mellanox.co.il>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
MIME-Version: 1.0
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling
	routines
Message-ID: <OF9332FF11.38007290-ON87257169.00673F71-88257169.006C7F6E@us.ibm.com>
From: Shirley Ma <xma@us.ibm.com>
Date: Tue, 9 May 2006 11:51:58 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 006C7F6288257169_="
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	openib-general-bounces@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 006C7F6288257169_=
Content-Type: text/plain; charset="US-ASCII"

"Michael S. Tsirkin" <mst@mellanox.co.il> wrote on 05/09/2006 11:44:52 AM:

> Quoting r. Shirley Ma <xma@us.ibm.com>:
> > According to some results from different resouces, NAPI only gives
> 3%-10% performance improvement on single CQ.
> 
> When you say performance you mean bandwidth.
> But I think it should improve the CPU utilization on RX side 
significantly.
> If it does, that an important metric as well.

No, CPU utilization wasn't reduced. When you use single CQ, NAPI polls on 
both RX/TX.

> > I am trying a simple NAPI patch on splitting CQ now to see how 
> much performance there.
> 
> What are you using for a benchmark?
> 
> -- 
> MST

netperf, iperf, mpstat, netpipe, oprofiling, what's your suggestion?

Thanks
Shirley Ma
IBM Linux Technology Center
15300 SW Koll Parkway
Beaverton, OR 97006-6063
Phone(Fax): (503) 578-7638





--=_alternative 006C7F6288257169_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>&quot;Michael S. Tsirkin&quot; &lt;mst@mellanox.co.il&gt;
wrote on 05/09/2006 11:44:52 AM:<br>
<br>
&gt; Quoting r. Shirley Ma &lt;xma@us.ibm.com&gt;:<br>
&gt; &gt; According to some results from different resouces, NAPI only
gives<br>
&gt; 3%-10% performance improvement on single CQ.<br>
&gt; <br>
&gt; When you say performance you mean bandwidth.<br>
&gt; But I think it should improve the CPU utilization on RX side significantly.<br>
&gt; If it does, that an important metric as well.<br>
<br>
No, CPU utilization wasn't reduced. When you use single CQ, NAPI polls
on both RX/TX.</tt></font>
<br>
<br><font size=2><tt>&gt; &gt; I am trying a simple NAPI patch on splitting
CQ now to see how <br>
&gt; much performance there.<br>
&gt; <br>
&gt; What are you using for a benchmark?<br>
&gt; <br>
&gt; -- <br>
&gt; MST</tt></font>
<br>
<br><font size=2 face="sans-serif">netperf, iperf, mpstat, netpipe, oprofiling,
what's your suggestion?</font>
<br><font size=2 face="sans-serif"><br>
Thanks<br>
Shirley Ma<br>
IBM Linux Technology Center<br>
15300 SW Koll Parkway<br>
Beaverton, OR 97006-6063<br>
Phone(Fax): (503) 578-7638<br>
<br>
</font>
<br>
<br><font size=2><tt><br>
</tt></font>
--=_alternative 006C7F6288257169_=--
