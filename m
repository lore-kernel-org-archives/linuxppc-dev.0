Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D626DDE06
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 13:00:10 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m34207Yx026495
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 22:00:07 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m34207cK233548
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 22:00:07 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m34206l4029956
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Apr 2008 22:00:07 -0400
Date: Thu, 3 Apr 2008 20:59:27 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH] Add idle wait support for 44x platforms
Message-ID: <20080403205927.16fc0ae7@zod.rchland.ibm.com>
In-Reply-To: <20080403230356.GJ20457@bakeyournoodle.com>
References: <7226bef216680748a503.1207262582@thinkpadL>
	<20080403230356.GJ20457@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 4 Apr 2008 10:03:56 +1100
tony@bakeyournoodle.com (Tony Breeds) wrote:

> > +int __init ppc44x_idle_init(void)
> > +{
> > +	if(of_find_node_by_path("/hypervisor") != NULL) {
>           ^ space
> > +		/* if we find /hypervisor node is in device tree,
> > +		   set idle mode to wait */
> > +		current_mode = 1; /* wait mode */
> > +	}
> 
> You don't really need the braces {} here.

They are technically not required, but I like them there none the
less because of the multi-line comment.  I find it to be better style
personally.

josh
