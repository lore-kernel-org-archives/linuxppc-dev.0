Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 178FBDDEF7
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 22:48:30 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m34BkbhD019205
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 07:46:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m34BmQwa114598
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 05:48:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m34BmQrL009294
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2008 05:48:26 -0600
Date: Fri, 4 Apr 2008 06:47:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: jyoung5@us.ibm.com
Subject: Re: [PATCH] Add idle wait support for 44x platforms
Message-ID: <20080404064741.69f8669b@zod.rchland.ibm.com>
In-Reply-To: <1207289558.6971.15.camel@thinkpadL>
References: <7226bef216680748a503.1207262582@thinkpadL>
	<20080403230356.GJ20457@bakeyournoodle.com>
	<1207289558.6971.15.camel@thinkpadL>
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

On Fri, 04 Apr 2008 01:12:38 -0500
Jerone Young <jyoung5@us.ibm.com> wrote: 
> > 
> > > +static int current_mode = 0;
> > 
> > Leave this as: static int current_mode;, so it'll end up in the bss
> 
> The problem here is that this defines the default case. Is there really
> a benefit having this in bss ?

It's still defined to 0 if it's in the BSS, as that is all initialized
to 0.

josh
