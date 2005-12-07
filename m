Return-Path: <blofeldus@yahoo.com>
Received: from web53515.mail.yahoo.com (web53515.mail.yahoo.com
	[206.190.39.70]) by ozlabs.org (Postfix) with SMTP id 5410C688A3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 04:30:03 +1100 (EST)
Message-ID: <20051207172321.77464.qmail@web53515.mail.yahoo.com>
Date: Wed, 7 Dec 2005 09:23:21 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20051205203941.GA16695@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Re: Video Card to Lite5200 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What is the status of the mpc5200 support? I see Sylvain's repository
is still at 2.6.12 (5 months old).

http://gitbits.246tnt.com/gitweb.cgi?p=linux-2.6-mpc52xx.git;a=summary

The current kernel.org kernel doesn't appear to support fec/DMA. Is
there a plan to get networking support into the mainstream kernel?

Thanks
-rb

--- Alessandro Rubini <rubini@gnudd.com> wrote:

> 
> > Note that the 5200 code in the kernel is work in progress. I  do 
> not
> > cleaim  that it does work in any way. If you want stable code use
> our
> > 2.4.25 kernel instead.
> 
> FWIW, I have your 2.6.14 happily running on the lite5200, with PCI,
> IDE (no DMA though) and flash.
> 
> I can publish the patches, if anyone is interested. Until now I
> didn't,
> as Sylvain's work is considered the official one (but it didn't have
> IDE last time I checked -- and I don't have bitkeeper to pull it).
> 
> /alessandro
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 
