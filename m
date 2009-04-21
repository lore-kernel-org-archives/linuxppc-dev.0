Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FCD8DE474
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 06:33:09 +1000 (EST)
Message-Id: <29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <49EE2CD8.7010700@mlbassoc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PCI changes 2.6.26 => 2.6.28
Date: Tue, 21 Apr 2009 15:33:03 -0500
References: <49EDF333.4000200@mlbassoc.com> <49EE2CD8.7010700@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 21, 2009, at 3:30 PM, Gary Thomas wrote:

> The [two] big differences I see are that the video card (00:0d.0)
> is being assigned 0xC0000000, which lspci marks as "virtual".
> I think I've had trouble in the past with memory regions which
> started at 0 relative to the PCI space.  Also "virtual" concerns me.
>
> Does this spark any ideas from anyone?

Doesn't ring any bells.  What does cat /proc/iomem look like between  
the two kernels.

- k
