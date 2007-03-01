Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 31FC1DDF10
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 06:18:19 +1100 (EST)
In-Reply-To: <795221.8746.qm@web302.biz.mail.mud.yahoo.com>
To: Ben Warren <bwarren@qstreams.com>
Subject: Re: Kernel support for the TI1520 PCI-CardBus bridge?
MIME-Version: 1.0
Message-ID: <OF47D2DFEA.BFE6D63F-ON88257291.006962FB-88257291.006A06FF@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 1 Mar 2007 11:18:11 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ben,

Ben Warren <bwarren@qstreams.com> wrote on 03/01/2007 04:00:27 AM:

> Bruce,
> --- Bruce_Leonard@selinc.com wrote:
> 
> > Hi all,
> > 
> > We're designing a new product and we want to put a
> > CF card in it.  We're 
> 
> If you don't need hot-plugging and happen to be using
> either a Freescale PowerQUICCx or IBM/AMCC 4xx chip,
> you might consider connecting directly to the local
> bus and operating in TrueIDE mode.  This has
> limitations, but has been done many times.
> 
> regards,
> Ben

Thanks for the feedback.  We've considered doing that.  We're using a 
MPC8347 and have FS's 8349ITX ref design which is where we got the idea of 
using the local bus.  But digging into our requirements more we found that 
we want to support Compact Flash + cards in addition to Compact Flash 
Storage cards.  Also, in the future, we'll probably want to support more 
than one card at a time.  That's why we decided a PCI-CF bridge with two 
slots would be a better solution.

A related question (since I'm new to this PCMCIA/CardBus/Compact Flash 
world): what is a yenta-compatible device?  I know it's some how tied up 
in all of this, but googling it doesn't give me any usefull results.  Or 
is this question/thread better asked on the linux-pcmcia list?

Take care and stay safe.

bruce
