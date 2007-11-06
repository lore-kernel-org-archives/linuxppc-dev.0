Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25B43DDE2D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 03:47:16 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lA6GlB5q186400
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 16:47:11 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.6) with
	ESMTP id lA6GlBuN3096724
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 16:47:11 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA6GksWR029092
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 16:46:55 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: aglitke <agl@us.ibm.com>
Subject: Re: problem in follow_hugetlb_page on ppc64 architecture with
	get_user_pages
Date: Tue, 6 Nov 2007 17:39:34 +0100
References: <OF6FC435A0.F59C9AD9-ONC125738B.002A5195-C125738B.002A424A@de.ibm.com>
	<1194361532.20383.4.camel@localhost.localdomain>
In-Reply-To: <1194361532.20383.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711061739.34952.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Adam!
On Tuesday 06 November 2007 16:05, aglitke wrote:
> Please try this patch and see if it helps.
Tested on 2.6.22 (don't have the system with 2.6.23 at the moment) and
the testcase ran perfectly.
Thanks!
Nam
