Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FD9FDE791
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 03:52:09 +1000 (EST)
Message-Id: <45E20E37-8AC3-46CE-ABC5-AB469AFF9D6E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080429155333.GC28166@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/3] [POWERPC] 86xx: mpc8610_hpcd: use ULI526X driver for
	on-board ethernet
Date: Tue, 29 Apr 2008 12:52:03 -0500
References: <20080429155333.GC28166@polina.dev.rtsoft.ru>
Cc: netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2008, at 10:53 AM, Anton Vorontsov wrote:
>  floating around (and also included in the
> BSP), which tries to heal the situation, though the ethernet is still
> unusable. Practically it takes ages to mount NFS filesystem:
>
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 180k init
> nfs: server 10.0.0.2 not responding, still trying
> nfs: server 10.0.0.2 OK
> nfs: server 10.0.0.2 not responding, still trying
> nfs: server 10.0.0.2 not responding, still trying
> nfs: server 10.0.0.2 not responding, still trying
> nfs: server 10.0.0.2 not responding, still trying
> nfs: server 10.0.0.2 OK
> nfs: server 10.0.0.2 not responding, still trying
>
> So, instead of trying to add uli526x functionality into TULIP driver
> (which is already bloated enough), I fixed existing ULI526X driver
> and now it works perfectly well here.

I'm assuming patches that fix the uli526x driver have been accepted by  
jeff.

- k
