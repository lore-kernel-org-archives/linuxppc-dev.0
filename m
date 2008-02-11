Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB7B2DDEF1
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 21:47:59 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m1BAlqUf130432
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 10:47:52 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m1BAlqwX2080886
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:47:52 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m1BAlpo9020355
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:47:51 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH][RESEND] drivers/base: export (un)register_memory_notifier
Date: Mon, 11 Feb 2008 11:47:50 +0100
References: <200802111049.05478.ossthema@de.ibm.com>
	<1202724743.8276.2.camel@nimitz.home.sr71.net>
In-Reply-To: <1202724743.8276.2.camel@nimitz.home.sr71.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802111147.51225.ossthema@de.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 11 February 2008 11:12, Dave Hansen wrote:
> On Mon, 2008-02-11 at 10:49 +0100, Jan-Bernd Themann wrote:
> > are you the right person to address this patch to?
> 
> You might want to check the top of the file. ;)
> 
> > --- a/drivers/base/memory.c
> > +++ b/drivers/base/memory.c
> > @@ -52,11 +52,13 @@ int register_memory_notifier(struct notifier_block *nb)
> >  {
> >          return blocking_notifier_chain_register(&memory_chain, nb);
> >  }
> > +EXPORT_SYMBOL(register_memory_notifier);
> >  
> >  void unregister_memory_notifier(struct notifier_block *nb)
> >  {
> >          blocking_notifier_chain_unregister(&memory_chain, nb);
> >  }
> > +EXPORT_SYMBOL(unregister_memory_notifier);
> 
> Is there a particular reason these can't be GPL?
> 

I don't object to make them GPL. Greg, what do you think?

Regards,
Jan-Bernd
