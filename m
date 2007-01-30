Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 585E6DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 09:32:21 +1100 (EST)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901064432D9@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901064432D9@EMPBEDEX.empirix.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2B407BB2-BBA6-4B13-BF34-DABFB3F8ADEF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: options for root file system for MPC8548
Date: Tue, 30 Jan 2007 16:31:21 -0600
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2007, at 4:19 PM, Morrison, Tom wrote:

> Hi,
>
> I've seen a couple threads about root file systems and such,
> but I am hoping this is slightly more detailed in what I am
> looking for!
>
> What is the best means to generate/use/support a root file system?
>
> I can download and use ELDK to generate one, but it doesn't look
> like it has all the library / utility package support required by
> my application (e.g.: perl).
>
> We do NOT want to use LTIB (supplied by Freescale) to create one
> (for multiple reasons - including the same as ELDK).

Can you elaborate on what issues you have with ELDK/LTIB, is it just  
package support?  If so it might be useful for the developers to know  
what packages you're interested in.  Or if there are other issues  
with them.

> I could purchase one via RedHat or MontaVista (but they are
> expensive and their kernel support is behind).
>
> Has anyone any experience with LinuxLink (TimeSys)
> http://lldn.timesys.com.
> It looks promising - but I'd like to hear if others have used them?

Can't say that I have.

- k
