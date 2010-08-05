Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81F86B70D0
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 12:04:39 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add vmcoreinfo symbols to allow makdumpfile
	to filter core files properly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Neil Horman <nhorman@tuxdriver.com>
In-Reply-To: <20100804144929.GA13970@hmsreliant.think-freely.org>
References: <20100713134609.GA14514@hmsreliant.think-freely.org>
	<20100804144929.GA13970@hmsreliant.think-freely.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Aug 2010 12:04:26 +1000
Message-ID: <1280973866.1902.168.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, paulus@samba.org, vgoyal@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-08-04 at 10:49 -0400, Neil Horman wrote:
> Ping yet again. Ben, This needs review/acceptance from you or Paul
> Neil 

Isn't it already in powerpc-next about to be pulled by Linus ?

In general, I recommend you check the status of your patches on
patchwork. I'm nagging Jeremy to add a feature so it emails the
submitter when the patch status changes :-)

Cheers,
Ben.
