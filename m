Return-Path: <ahuja@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5905BDDEF4
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 10:19:43 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09NJau3003145
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 18:19:36 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09NJZ5d091274
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 18:19:35 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09NJZqV013605
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 18:19:35 -0500
Message-ID: <4785565D.80701@austin.ibm.com>
Date: Wed, 09 Jan 2008 17:18:53 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
References: <4782B985.2090508@austin.ibm.com>	<4782C026.8080302@austin.ibm.com>
	<20080109042911.GT14201@localdomain>	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>	<20080109184437.GU14201@localdomain>
	<1199919545.7880.11.camel@concordia>
In-Reply-To: <1199919545.7880.11.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: lkessler@us.ibm.com, linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	mahuja@us.ibm.com, Linas Vepstas <linasvepstas@gmail.com>,
	strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It's in "production" with 256MB of RAM? Err. Sure as the dump progresses
> more RAM will be freed, but that's hardly production. I think Nathan's
> right, any sysadmin who wants predictability will probably double reboot
> anyway.

Thats a changeable parameter. Its something we chose for now. It by no means
is set in stone. Its not a design parameter. If you like to allocate 1GB we can.
But that is something we did for now. we expect this to be a variable value
dependent upon the size of the system. So if you have 128 GB system and you 
can spare 10 gb, you should be able to have 10 GB to boot with. 
