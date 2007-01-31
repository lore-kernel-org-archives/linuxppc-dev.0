Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6939CDDF05
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 01:53:49 +1100 (EST)
In-Reply-To: <000601c74531$62220820$6405a8c0@absolut>
References: <mailman.1454.1170226011.9285.linuxppc-embedded@ozlabs.org>
	<000601c74531$62220820$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0ACC0A3E-9DF3-4927-8F67-E525BA0E6C13@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Audigy SE / ca0106 driver for PowerPC?
Date: Wed, 31 Jan 2007 08:52:47 -0600
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


On Jan 31, 2007, at 6:14 AM, Russell McGuire wrote:

> All,
>
> I recently tried to plugin and use an Audigy SE PCI card with  
> 2.6.20 and
> noticed that it would lock up during driver registration.
>
> After a little digging, I found that the interrupt routine and a  
> few other
> functions are relying on the x86 inl() / outl() to read from the  
> sound card.
>
> Is anyone aware of a PPC port for this driver? Or if it would be  
> feasible? I
> haven't ported a driver between architectures before.
>
> Or does the inl() / outl() already have PPC equivalent functions  
> and I need
> to be looking for a PCI configuration problem with my system?

We implement these on PPC.  Clearly we don't have x86 style port IO,  
usually its handled by memory mapped access to a special region of  
memory that will be converted into a PCI IO space access.

- k
