Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4745867BAD
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 11:55:48 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAH0u6kd003024
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 19:56:06 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAH0tj6f280408
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 19:55:45 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAH0tiWZ003111
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 19:55:45 -0500
Date: Thu, 16 Nov 2006 18:55:40 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH]: HVCS char driver janitoring: fix compile warnings
Message-ID: <20061117005540.GF23600@austin.ibm.com>
References: <20061115212619.GJ8395@austin.ibm.com>
	<1163635387.8805.7.camel@localhost.localdomain>
	<20061116203946.GA23600@austin.ibm.com>
	<1163716536.16815.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163716536.16815.5.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Alan Cox <alan@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 17, 2006 at 09:35:36AM +1100, Michael Ellerman wrote:
> 
> Thanks, new patches look good.

Any clue who I should send these to? I think akpm took the earlier
one, I'm not clear if that means it will slosh into Linus' tree 
eventually.

--linas
