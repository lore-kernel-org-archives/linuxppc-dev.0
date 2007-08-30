Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E13D2DDE9A
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 11:04:51 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7U14mPA027960
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 21:04:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7U14m5Q362664
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 19:04:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7U14lH1022929
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 19:04:48 -0600
Subject: Re: [PATCH 0/4] PowerPC 440EPx: Initial Sequoia support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20070829133520.GA19925@ru.mvista.com>
References: <20070829133520.GA19925@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 29 Aug 2007 19:28:18 -0500
Message-Id: <1188433699.3515.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-29 at 17:35 +0400, Valentine Barshak wrote:
> The following patches add initial PowerPC 440EPx Sequoia board support.
> The code is based mainly on the Bamboo board support by Josh Boyer.
> These patches have been modified according the comments for the previous
> 440EPx Sequoia patch series.

I see David has beaten me to reviewing the individual patches, which of
course is always welcome.  I just wanted add that I also think these
look good.  Thanks!

josh
