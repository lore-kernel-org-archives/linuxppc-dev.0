Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9D57DE050
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 07:05:22 +1000 (EST)
Message-ID: <49DD1154.3040106@kernel.org>
Date: Wed, 08 Apr 2009 14:04:20 -0700
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>	
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>	
	<1239156559.10104.7.camel@localhost>
	<ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
In-Reply-To: <ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> On Tue, Apr 7, 2009 at 9:09 PM, Michael Ellerman <michael@ellerman.id.au> wrote:
> 
>> Have you confirmed that INTX is disabled before that call?
> 
> How do I do that?

Running "lspci -nnvvvxxx" before loading the driver should be enough.

-- 
tejun
