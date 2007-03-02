Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32826DDF7F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 10:24:23 +1100 (EST)
In-Reply-To: <000c01c75d1e$80abe720$6405a8c0@absolut>
References: <mailman.1048.1172865151.21008.linuxppc-embedded@ozlabs.org>
	<000c01c75d1e$80abe720$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0284774D-36B2-4163-BE9F-50F10F4F18FF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8360E - PCI - BRIDGE
Date: Fri, 2 Mar 2007 17:23:27 -0600
To: rmcguire@videopresence.com
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


On Mar 2, 2007, at 4:59 PM, Russell McGuire wrote:

> I was wondering if anyone had a small suggestion of PCI cards to begin
> testing Linux with for debugging a PCI bus / software / setup.
>
> Basically I am looking for a couple of cards that are known to have  
> good
> working PPC drivers for PCI, hopefully built-in into the kernel.  
> Preferable
> that somebody has first has experience with.
>
> I seem to be having issues with Linux only, and getting my PCI  
> stuff to
> work. Still not sure if these are DTV blob issues, or  
> incompatibility with
> the PCI-PCI bridge chip I have in the PPC system.
>
> Questions:
>
> 1) Can somebody provide the names of just a few cards that have  
> been tested
> with these 82xx 83xx PCI busses that have worked in Linux 2.6.xx? I  
> hope to
> not be fighting endian issues in the drivers at first.

Intel e100/e1000 cards are usually pretty good candidates.

> 2) What is available / known about PCI bridge compatibility /  
> enumeration
> when it comes to PPC architecture? I know Linux sees the bridge,  
> but are
> there mapping compatibility issues introduced if an extra bridge is in
> place?

The main issue is related to setting up the bridge.  We seem to  
handle this before linux is involved in most cases.

> 3) Directly related to Question 2, is there any special options  
> have to be
> enabled in the Linux 2.6.xx kernel <2.6.20 specifically> to make this
> happen? PreP compliance, G5 support, no idea I am just throwing ideas.

Nope, just PCI support.  The key as mentioned above is having the P2P  
bridge setup properly.

> Any help appreciated, I was hoping originally that once the PCI was  
> happy
> inside U-boot that Linux wouldn't be such a far target.

That's true, if you have u-boot setup and seeing your devices than it  
shouldn't be too far for the linux.

- k
