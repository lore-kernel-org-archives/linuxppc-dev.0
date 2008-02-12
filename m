Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 7199FDDECB
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:41:08 +1100 (EST)
Message-ID: <47B0EB23.9040101@pikatech.com>
Date: Mon, 11 Feb 2008 19:41:07 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
	<20080211031110.GD11572@localhost.localdomain>
	<47AFC5E3.20101@pikatech.com>
	<20080211235958.GD18348@localhost.localdomain>
	<47B0F142.40206@pikatech.com>
	<20080212002030.GE18348@localhost.localdomain>
In-Reply-To: <20080212002030.GE18348@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> Err.. now I'm doubly confused.  Initially I thought you'd need to
> change the size part of reg somewhere, but your description above just
> convinced me you didn't (because you were essentially just shifting a
> 4M map up into the high rather than low 4M of the 64M space).  Now
> you're saying you do..
>   
If you tell the mtd driver that the flash is 64M, when it is really 4M, 
it goes oops. So you do have to get the size right in the reg field.

Cheers,
   Sean
