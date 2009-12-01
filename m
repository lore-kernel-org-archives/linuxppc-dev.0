Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1103B6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 23:48:05 +1100 (EST)
Message-ID: <4B151087.7080606@kernel.org>
Date: Tue, 01 Dec 2009 21:48:07 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: hmacht@suse.de
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
References: <20091201070834.6A840B7B63@ozlabs.org>
	<4B14CD22.4020806@kernel.org> <200912011344.38656.hmacht@suse.de>
In-Reply-To: <200912011344.38656.hmacht@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2009 09:44 PM, Holger Macht wrote:
> I do not remember any specific reason for using ata_port_schedule_eh(). I
> guess it's just there because the previous implementation used
> it. ata_port_freeze()/abort() might as well work properly. However, I
> would hesitate to change the existing code, because verifying that
> everything works contains quite some effort. There are so many different
> use cases this code can be accessed with and it has to be verified with
> all kind of different hardware to make sure we get no hard
> freezes. Testing that freeze()/abort() in this new driver would be worth a
> try, though. Next time I have setup my test environment again I can verify
> that it also works in the general libata-acpi code.

Yeap, agreed.  It was pretty painful get it right the last time
around, so changing it on a hunch would be a pretty bad idea.  If you
have a chance to try freeze or abort, please keep me posted.

Thanks.

-- 
tejun
