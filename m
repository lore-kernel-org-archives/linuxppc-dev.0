Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EB10DDFBA
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 09:51:44 +1100 (EST)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90106443362@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901064432D9@EMPBEDEX.empirix.com>
	<2B407BB2-BBA6-4B13-BF34-DABFB3F8ADEF@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90106443362@EMPBEDEX.empirix.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21F08FBD-6702-46A2-9592-329D8CF04073@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: options for root file system for MPC8548
Date: Tue, 30 Jan 2007 16:50:46 -0600
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


On Jan 30, 2007, at 4:42 PM, Morrison, Tom wrote:

> You are quick with the questions...:-)

I know :)

I think the timesys solution maybe what you're looking for since they  
seem to handle security updates to the packages and such.  My concern  
would be how the handle the e500 platform from a packing point of view.

Do they have just 'ppc' packages, or are they targeted to specific  
families.

I mean if you're not concerned about FP performance, use debian/ 
fedora/ etc and turn on FP emulation in the kernel.

- k

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Subject: Re: options for root file system for MPC8548
>
>
> On Jan 30, 2007, at 4:19 PM, Morrison, Tom wrote:
> <snip intro>
>> We do NOT want to use LTIB (supplied by Freescale) to create one
>> (for multiple reasons - including the same as ELDK).
>
> Can you elaborate on what issues you have with ELDK/LTIB, is it just
> package support?  If so it might be useful for the developers to know
> what packages you're interested in.  Or if there are other issues
> with them.
>
> LTIB uses busybox and in general seems very limited in its support
> (as well as currently backdated in terms of kernel support).
> ELDK has an incredible set of packages that it supports, but
> things like many of the scripting languages support (e.g.: PERL),
> additional security libraries(e.g.: ipsec), general network
> libraries (e.g.: libpcap), and some network utilities (e.g.: wget).
>
> Individually, none of these are serious, but altogether it's a lot
> to manage - if I had 1 stop shopping, I might go there instead of
> with the ever incredible ELDK!
>
> <snip rest>
