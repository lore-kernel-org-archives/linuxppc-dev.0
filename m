Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND01.psi.ch (mailsend01.psi.ch [129.129.191.53])
	by ozlabs.org (Postfix) with ESMTP id F40B7DE352
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 00:48:57 +1000 (EST)
Date: Mon, 27 Aug 2007 16:36:48 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40708270724r3d1a3bd3jccbc161475e93343@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0708271634110.30948-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi Grant,

	Thank you for your response.

My u-boot bootargs is set to:
console=ttyUL0,9600 root=/dev/nfs rw nfsroot=129.117.144.113:/opt/eldk41/ppc_4xx,tcp  ip=::::virtex4-mirek:eth0:dhcp panic=1

where I can find __log_buf for kernel messages?



Best Regards

Mirek



On Mon, 27 Aug 2007, Grant Likely wrote:

> On 8/27/07, Mirek23 <miroslaw.dach@psi.ch> wrote:
> > 4. I am trying to start the kernel
> >
> > => bootm 0x1000000
> >
> > ## Booting image at 01000000 ...
> > Image Name:   Linux-2.6.21-rc6
> > Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> > Data Size:    991375 Bytes = 968.1 kB
> > Load Address: 00000000
> > Entry Point:  00000000
> > Verifying Checksum ... OK
> > Uncompressing Kernel Image ... OK
> 
> Have you looked in __log_buf for kernel messages?
> What does your u-boot env look like?
> Do you have 'console=ttyUL0' or 'console=ttyS0' in the kernel command line?
> 
> Cheers,
> g.
> 
> 

-- 
=============================================================================
          Miroslaw Dach (Miroslaw.Dach@psi.ch) - SLS/Controls Group 
                PSI - Paul Scherrer Institut CH-5232 Villigen
=============================================================================
