Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63900DDD01
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 00:47:58 +1100 (EST)
Message-Id: <3247527D-1FD0-420F-99C6-9DADBB79B020@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <49D45D4F.3010103@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
Date: Thu, 2 Apr 2009 08:47:47 -0500
References: <49C26434.30302@grandegger.com>	
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>	
	<49D1E3E5.3080607@grandegger.com>	
	<fa686aa40903310623r2b2db0adjb912cfefd3a321e2@mail.gmail.com>	
	<49D21C75.7060307@grandegger.com>	
	<fa686aa40903310805k794b9df0s4d21a8080907a767@mail.gmail.com>	
	<20090331155443.GA28242@oksana.dev.rtsoft.ru>	
	<49D3197C.7000806@grandegger.com>
	<fa686aa40904010540h53c8975ao196657f6fdd66583@mail.gmail.com>
	<49D367C7.5010802@grandegger.com>
	<D7365D0C-57B0-479C-9335-265620B8E5AE@kernel.crashing.org>
	<49D45D4F.3010103@grandegger.com>
Cc: linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 2, 2009, at 1:38 AM, Wolfgang Grandegger wrote:

>
> Socrates is a new board and it has no problem using an up-to-date
> version of U-Boot. The socrates.dts file in your "next" tree already  
> has
> the "device_type = "soc" removed. We need to add "fsl,soc" to the
> "compatible" property and update fsl_get_sys_freq(), etc. to search  
> for
> it as well. And U-Boot should use the same name to fixup the
> frequencies. Are you already working on that issue? Should I provide
> patches?
>

I'm not working on it at all.  I'm also guessing at this point the  
Socrates support is in Linus tree :)

- k
