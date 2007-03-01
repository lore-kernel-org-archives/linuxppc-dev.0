Return-Path: <bwarren@qstreams.com>
Received: from web302.biz.mail.mud.yahoo.com (web302.biz.mail.mud.yahoo.com
	[68.142.199.178]) by ozlabs.org (Postfix) with SMTP id 05EACDDE41
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 23:00:29 +1100 (EST)
Date: Thu, 1 Mar 2007 04:00:27 -0800 (PST)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: Kernel support for the TI1520 PCI-CardBus bridge?
To: Bruce_Leonard@selinc.com, linuxppc-embedded@ozlabs.org
In-Reply-To: <OFB8991C41.CAB80F63-ON88257291.0008226D-88257291.0008B663@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <795221.8746.qm@web302.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce,
--- Bruce_Leonard@selinc.com wrote:

> Hi all,
> 
> We're designing a new product and we want to put a
> CF card in it.  We're 
> thinking the easiest way to do that is to put in a
> PCI-CF bridge and we 
> would like to use the TI1520 because it's industrial
> rated which we need. 
> We can get the parts but TI is refusing to give us
> any support because 
> they're devoting 100% of their time to dealing with
> the Vista release. I'm 
> curious if anyone has ever successfully gotten this
> part to work in linux. 
>  I found it listed in pci_ids.h, but that doesn't
> mean it's actually 
> used/working.  I'm not looking for a detailed
> explination right now, we're 
> just trying to gage if this part would be a couple
> of weeks of work or a 
> couple of months.  Thanks for any info.

If you don't need hot-plugging and happen to be using
either a Freescale PowerQUICCx or IBM/AMCC 4xx chip,
you might consider connecting directly to the local
bus and operating in TrueIDE mode.  This has
limitations, but has been done many times.

regards,
Ben
