Return-Path: <johnrose@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F3C3DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 03:23:41 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1MGNcib016672
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 11:23:38 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1MGNaoe268444
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 09:23:36 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1MGNZYl019221
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2007 09:23:35 -0700
Subject: Re: [PATCH 1/2] ibmebus: dynamic add/remove, uevent, root device
	and whitespace
From: John Rose <johnrose@austin.ibm.com>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200702220615.51332.hnguyen@linux.vnet.ibm.com>
References: <200702220615.51332.hnguyen@linux.vnet.ibm.com>
Content-Type: text/plain
Message-Id: <1172161235.20962.2.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Thu, 22 Feb 2007 10:20:35 -0600
Cc: Paul Mackerras <pmac@au1.ibm.com>, fenkes@de.ibm.com,
	lkml <linux-kernel@vger.kernel.org>,
	External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Me Notes <johnrose@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks great!

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
