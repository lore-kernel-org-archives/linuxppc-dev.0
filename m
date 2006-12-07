Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2B3A67BEB
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 08:05:38 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB7L5SJx003793
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 16:05:28 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB7L5SSS435194
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 14:05:28 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB7L5SFe020814
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 14:05:28 -0700
Date: Thu, 7 Dec 2006 15:05:27 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] add rtas_service_present() helper
Message-ID: <20061207210527.GC4614@austin.ibm.com>
References: <11654526463043-git-send-email-ntl@pobox.com>
	<11654526511379-git-send-email-ntl@pobox.com>
	<11654526533213-git-send-email-ntl@pobox.com>
	<1165459893.14780.0.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1165459893.14780.0.camel@concordia.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 07, 2006 at 01:51:33PM +1100, Michael Ellerman wrote:
> On Wed, 2006-12-06 at 18:50 -0600, Nathan Lynch wrote:
> > To test for the existence of an RTAS function, we typically do:
> > 
> >    foo_token = rtas_token("foo");
> >    if (foo_token == RTAS_UNKNOWN_SERVICE)
> >       return;
> > 
> > Add a rtas_service_present method, which provides a more conventional
> > boolean interface for testing the existence of an RTAS method.
> 
> 
> I like it a lot ..

Me too ... How about making it inline?

--linas
