Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DC8F67DED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 23:40:19 +1000 (EST)
Date: Fri, 29 Jul 2005 14:40:15 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "Tiago Dall'Agnol" <tdallagnol@parks.com.br>
Message-Id: <20050729144015.09fec9fe.ajz@cambridgebroadband.com>
In-Reply-To: <42EA2A2E.5040708@parks.com.br>
References: <20050729013303.33814.qmail@web40712.mail.yahoo.com>
	<42EA2A2E.5040708@parks.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: request_8xxirq
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In linux-2.4 it's in 

	include/asm-ppc/mpc8xx.h

-- snip --
#define request_8xxirq request_irq
--/snip --

And request_irq is in arch/ppc/kernel/irq.c

Alex

On Fri, 29 Jul 2005 10:07:58 -0300
"Tiago Dall'Agnol" <tdallagnol@parks.com.br> wrote:

> Hi,
> 
> I had some problems with irq in my embedded system. I'm interested in 
> this function source code, but I didn't find it in my linux distribuction?
> 
> Does anyone know where I can find it?
> 
> Thanks a lot
> Tiago
> 
> Manish Joshi wrote:
> 
> > Hi,
> >  
> > I am working on an old code which uses  request_8xxirq() call which I 
> > can't find in latest kernel.
> > Has this been replaced by something else ?
> >  
> > I see the references on net about replacing request_8xxirq()  with 
> > request_irq(). Can I do it ?
> >  
> > TIA,
> > Manish
> >  
> >
> > ------------------------------------------------------------------------
> > Start your day with Yahoo! - make it your home page 
> > <http://us.rd.yahoo.com/evt=34442/*http://www.yahoo.com/r/hs>
> >
> >------------------------------------------------------------------------
> >
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> 
> -- 
> Tiago Dall'Agnol
> Pesquisa e Desenvolvimento
> Tel.: +55.51.470.05.64
> Fax.: +55.51.470.05.70
> e-mail: tdallagnol@parks.com.br
> www.parks.com.br
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
