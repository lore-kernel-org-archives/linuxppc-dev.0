Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B1F8DDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 06:51:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4NKpcMA021514
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 16:51:38 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4NKpbvo232514
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 14:51:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4NKpYN7007418
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 14:51:37 -0600
Date: Wed, 23 May 2007 15:51:30 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] pseries: asm/pci-bridge.h CONFIG_ minor cleanup
Message-ID: <20070523205130.GB5921@austin.ibm.com>
References: <20070521231816.GH5921@austin.ibm.com>
	<1179794459.7189.2.camel@concordia.ozlabs.ibm.com>
	<20070522170058.GJ5921@austin.ibm.com>
	<1179882692.6145.8.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179882692.6145.8.camel@concordia.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 23, 2007 at 11:11:32AM +1000, Michael Ellerman wrote:
> 
> Yeah who knows. The hole doesn't really matter unless the struct gets
> bigger, having the EEH stuff at the bottom makes it read better which is
> probably more important.

Havin become proficient at adding hex addrs in my head, I have also
come to appreciate structs which have all the important/hot stuff
at the top, instead of large filler holes that one has to skip over
during debugging.

--linas
