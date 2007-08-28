Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND01.psi.ch (mailsend01.psi.ch [129.129.191.53])
	by ozlabs.org (Postfix) with ESMTP id 4767BDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 23:37:19 +1000 (EST)
Date: Tue, 28 Aug 2007 15:37:18 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40708280602vc00920do459a087c25b830e1@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0708281531060.3856-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

	Thanks for your answer.
I have found in the System.map :
c020f0c4 b __log_buf

Is the address c020f0c4 relative to the .data segment?

I understand that when the system hangs I should type in the XMD window 
stop.

Is there anyway to examine the memory from the XMD window? or should I 
reload the u-boot and examine the memory from u-boot?

Best Regards

Mirek



On Tue, 28 Aug 2007, Grant Likely wrote:

> On 8/28/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> > Linux/PPC load: console=ttyUL0,9600 root=/dev/nfs rw
> > nfsroot=129.117.144.113:/opt/eldk41/ppc_4xx,tcp
> > ip=::::virtex4-mirek:eth0:dhcp panic=1
> > Uncompressing Linux...
> >
> >
> > After that system just hangs.
> >
> > I do not understand why it is possible to run zImage.elf straight from jtag
> > but it hangs when started from u-boot.
> >
> > Is it any fundamental problem with running Linux from u-boot on ML403
> > (Virtex-4) boards?
> 
> No there isn't.  It should work.  Most likely the kernel did not hang
> immediately, but rather the console is not setup correctly.  You need
> to halt the processor after the hang and look at __log_buf in memory
> (Find the address in System.map).
> 
> Cheers,
> g.
> 
> >
> > Best Regards
> >
> > Mirek
> >
> >
> 
> 
> 

-- 
=============================================================================
          Miroslaw Dach (Miroslaw.Dach@psi.ch) - SLS/Controls Group 
                PSI - Paul Scherrer Institut CH-5232 Villigen
=============================================================================
