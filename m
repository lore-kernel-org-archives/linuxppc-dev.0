Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2374867A67
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 02:31:20 +1000 (EST)
Date: Tue, 25 Apr 2006 09:31:18 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425163118.GD20228@gate.ebshome.net>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
	<A64C3686-0123-4750-BA7B-630E8BF2E4D8@kernel.crashing.org>
	<20060425161200.GC20228@gate.ebshome.net>
	<6F7CAB43-B4C0-47DA-BC7D-3FD04A552131@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6F7CAB43-B4C0-47DA-BC7D-3FD04A552131@kernel.crashing.org>
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

On Tue, Apr 25, 2006 at 11:25:59AM -0500, Kumar Gala wrote:
> If we are talking about a reference board than I think this is an  
> absurd requirement.  If you are willing to update your kernel on such  
> a board why would you not be willing to update the firmware as well.

1) I don't have JTAG
2) I don't trust new U-Boot version
3) I want to be able to boot old kernels

What you are proposing is more like saying - we changed kernel 
user-space API, old applications aren't supported anymore, get the new 
libc and rebuild them all. For some reason we don't intentionally do 
this, I wonder why.

-- 
Eugene
