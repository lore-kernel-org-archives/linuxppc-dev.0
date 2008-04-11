Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1183DE399
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 00:13:41 +1000 (EST)
Message-Id: <82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080311171045.GB4684@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
Date: Fri, 11 Apr 2008 09:13:36 -0500
References: <20080311171045.GB4684@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 12:10 PM, Anton Vorontsov wrote:
> - get rid of `model = "UCC"' in the ucc nodes
>  It isn't used anywhere, so remove it. If we'll ever need something
>  like this, we'll use compatible property instead.
> - replace cell-index and device-id properties by fsl,ucc.
>
> Drivers are modified for backward compatibility's sake.

I'd prefer we use cell-index and not introduce "fsl,ucc".  I'm ok with  
dropping device-id and model (its implied in the compatiable).

- k
