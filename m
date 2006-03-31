Return-Path: <dwm@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3EDC9679E7
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 09:40:26 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VMeClO028925
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:40:12 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VMe2fG229826
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:40:02 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2VMe2jT030861
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:40:02 -0500
Message-Id: <200603312239.k2VMdtWP007243@falcon10.austin.ibm.com>
In-reply-to: <20060331160203.f2bf8b53.moilanen@austin.ibm.com> 
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH 0/2] Base pSeries PCIe support 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 31 Mar 2006 16:39:55 -0600
From: Doug Maxey <dwm@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 31 Mar 2006 16:02:03 CST, Jake Moilanen wrote:
>Here are the two base patches for PCIe on pSeries for 2.6.17.
>
>This is enough to probe, find, configure, and run basic I/O to PCIe
>enabled devices.
>

Where are the bindings for pcie?  In the papr?

Have you heard of any effort to publish?

++doug
