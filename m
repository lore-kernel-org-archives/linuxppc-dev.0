Return-Path: <benh@au1.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A7BF667B30
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 14:19:38 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.6/8.13.6) with ESMTP id k574ML9P6008990
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 14:22:22 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k574MWim145712
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 14:22:33 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k574JADC027780
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 14:19:10 +1000
Subject: Re: [PATCH] powerpc: Add udbg-immortal kernel option
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060607022412.GA5661@pb15.lixom.net>
References: <1149645981.27572.96.camel@localhost.localdomain>
	<20060607022412.GA5661@pb15.lixom.net>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 14:19:07 +1000
Message-Id: <1149653947.27572.113.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-06 at 19:24 -0700, Olof Johansson wrote:
> On Wed, Jun 07, 2006 at 12:06:20PM +1000, Benjamin Herrenschmidt wrote:
> >  		return;
> > +	if (strstr(saved_command_line, "udbg-immortal")) {
> > +		printk(KERN_INFO "early console immortal !\n");
> > +		return;
> > +	}
> 
> So it's YOU who add spaces before punctuation all over arch/powerpc!
> Please fix. ;-)

No way :) Besides, that's how it should be done in french :)

Ben.
