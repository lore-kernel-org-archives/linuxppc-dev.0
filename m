Return-Path: <annamaya@yahoo.com>
Received: from web53803.mail.yahoo.com (web53803.mail.yahoo.com
	[206.190.36.198]) by ozlabs.org (Postfix) with SMTP id 4BAE867A2C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 03:49:41 +1100 (EST)
Message-ID: <20050119164938.72597.qmail@web53803.mail.yahoo.com>
Date: Wed, 19 Jan 2005 08:49:38 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Christian-Hoffmann@siemens.com, linuxppc-embedded@ozlabs.org
In-Reply-To: <3F294367B36FF842B66CC65102BBA9B236C928@witb202a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: FW: cpm_spi.c under kernel 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

That reminds me that I need to make the spi driver
available somewhere all the time. But I am not sure
when I will be able to do that. Meanwhile, you should
be able to start of with the old driver for the 8xx
that should be around somewhere under the rubble. :-)
Or, you can start off with the sample code in u-boot
that was derived from the original driver.


--- Christian-Hoffmann@siemens.com wrote:

> 
> 
> >  -----Original Message-----
> > From: 	Hoffmann Christian Com ESY HD 652  
> > Sent:	Dienstag, 18. Januar 2005 11:55
> > To:	'linuxppc-dev@ozlabs.org'
> > Subject:	cpm_spi.c under kernel 2.6
> > 
> > hi, 
> > 
> > has anybody already ported the spi driver
> available in kernel 2.4.24
> > (arch/ppc/8260_io/cpm_spi.c) to kernel 2.6
> (2.6.8.1) ?
> > if so, where can i get it ?
> > 
> > regards
> > 
> > christian
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 
