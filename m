Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1B2167A65
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2006 18:38:39 +1100 (EST)
Date: Mon, 6 Mar 2006 08:38:34 +0100
From: Olaf Hering <olh@suse.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] return to OF via trap, not exit
Message-ID: <20060306073834.GA24869@suse.de>
References: <20060304191026.GA9815@suse.de>
	<200603061212.12815.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200603061212.12815.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Mar 06, Michael Ellerman wrote:


> I don't think I like it, on IBM firmware it takes us from this:
> 
> Elapsed time since release of system processors: 26005 mins 51 secs
> 
> zImage starting: loaded at 0x00400000 (sp: 0x01a1ffe0)
> Allocating 0x7edc50 bytes for kernel ...
> OF version = 'IBM,SF230_126'
> gunzipping (0x1c00000 <- 0x407000:0x6a04e4)...done 0x766880 bytes
> OF stdout device is: /vdevice/vty@30000000
> Error: You can't boot a kdump kernel from OF!
> EXIT called ok
> 0 >
> 
> 
> To this:

Which is likely ok because it saves us from typing .registers manually.
