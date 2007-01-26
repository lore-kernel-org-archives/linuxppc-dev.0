Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFDE9DE0A7
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 19:58:21 +1100 (EST)
In-Reply-To: <20070126065613.GB328@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
	<20070126065613.GB328@colo.lackof.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B75FCFBF-E92D-4283-A6BF-96517CE77C94@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
Date: Fri, 26 Jan 2007 09:57:48 +0100
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> You code appears to be nice simple clean and to not support MSI in
>> a useful way.  I may be reading too quickly but at the moment your
>> infrastructure appears useless if you are on a platform that doesn't
>> enforce MSI's get filtered with a legacy interrupt controller.
>
> Hrm?
> Isn't the point of MSI to avoid any sort of interrupt controller?

No, the point of MSI is that it travels in the normal data
stream (and stays ordered with it).  In the end it *has* to
touch an interrupt controller (maybe the CPU-internal one).


Segher
