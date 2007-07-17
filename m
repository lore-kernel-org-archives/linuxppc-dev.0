Return-Path: <xma@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70CF0DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 15:57:47 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6H5vgcw005245
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 01:57:42 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6H5vg6Q257162
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 23:57:42 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6H5vg92021922
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 23:57:42 -0600
Received: from d03mc012.boulder.ibm.com (d03mc012.boulder.ibm.com
	[9.17.195.88])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6H5vfnC021868
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 23:57:41 -0600
In-Reply-To: <ada1wf7vgfb.fsf@cisco.com>
Subject: Re: [ofa-general] Re: [PATCH 01/10] IB/ehca: Support for multiple
	event queues
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF19C85704.39162967-ON8725731B.002061DC-8825731A.0078A20B@us.ibm.com>
From: Shirley Ma <xma@us.ibm.com>
Date: Mon, 16 Jul 2007 22:57:40 -0700
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBF988DFB3E74C8f9e8a93df938690918c08BBF988DFB3E74C"
Cc: Joachim Fenkes <fenkes@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	general-bounces@lists.openfabrics.org,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
	OF-General <general@lists.openfabrics.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBF988DFB3E74C8f9e8a93df938690918c08BBF988DFB3E74C
Content-type: text/plain; charset=US-ASCII





Hello Roland,

>I still haven't seen much code using the feature or
>even any anecdotal information about the performance impact.

The multiple links performance has been significant improved according to
the prototype IPoIB-UD mode test for eHCA driver esepcially for two links
on the same adapter. I haven't tried mthca (PCI-X and PCI-E) yet.

Thanks
Shirley
--0__=08BBF988DFB3E74C8f9e8a93df938690918c08BBF988DFB3E74C
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Hello Roland,</tt><br>
<br>
<tt>&gt;I still haven't seen much code using the feature or<br>
&gt;even any anecdotal information about the performance impact.</tt><br>
<br>
The multiple links performance has been significant improved according to the prototype IPoIB-UD mode test for eHCA driver esepcially for two links on the same adapter. I haven't tried mthca (PCI-X and PCI-E) yet.<br>
<br>
Thanks<br>
Shirley</body></html>
--0__=08BBF988DFB3E74C8f9e8a93df938690918c08BBF988DFB3E74C--
