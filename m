Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D8BD679FC
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 02:51:11 +1000 (EST)
In-Reply-To: <20060425163118.GD20228@gate.ebshome.net>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
	<A64C3686-0123-4750-BA7B-630E8BF2E4D8@kernel.crashing.org>
	<20060425161200.GC20228@gate.ebshome.net>
	<6F7CAB43-B4C0-47DA-BC7D-3FD04A552131@kernel.crashing.org>
	<20060425163118.GD20228@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <361E7E3D-D61B-42B2-9FA9-0F9F3666931E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 11:51:05 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 11:31 AM, Eugene Surovegin wrote:

> On Tue, Apr 25, 2006 at 11:25:59AM -0500, Kumar Gala wrote:
>> If we are talking about a reference board than I think this is an
>> absurd requirement.  If you are willing to update your kernel on such
>> a board why would you not be willing to update the firmware as well.
>
> 1) I don't have JTAG
> 2) I don't trust new U-Boot version
> 3) I want to be able to boot old kernels
>
> What you are proposing is more like saying - we changed kernel
> user-space API, old applications aren't supported anymore, get the new
> libc and rebuild them all. For some reason we don't intentionally do
> this, I wonder why.

I dont think this is like the user-space API at all.  The binding  
between kernel and u-boot is actually pretty tight.  For certain  
config options you have to ensure that u-boot and the kernel agree  
(for example CONFIG_CPM2).

If you dont trust the new u-boot I dont know why you would trust the  
new kernel anymore.  Also, I find it difficult to believe people  
would not be willing to update a u-boot to get any bug or performance  
tweaks that might exist after the initial release that came on their  
board.

You can boot old kernels with the new u-boot if you want to.

- kumar
