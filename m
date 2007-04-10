Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8DDA7DDF19
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 01:25:21 +1000 (EST)
In-Reply-To: <3d42041d0704091227s2a3d6ad1pb6d5e0dbcbac375f@mail.gmail.com>
References: <3d42041d0704091227s2a3d6ad1pb6d5e0dbcbac375f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <694C1F2C-B8B7-4ABD-BC1B-E4E606A61C0C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Remove arch/powerpc/platforms/85xx/mpc8540_ads.h
Date: Tue, 10 Apr 2007 10:24:51 -0500
To: dagriego <dagriego@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2007, at 2:27 PM, dagriego wrote:

> Kumar,
> I'm looking at adding a platform based on the mpc8540ads and came  
> across the
> arch/powerpc/platforms/85xx/mpc8540_ads.h.  Is this file still needed
> for something?  If not, should I create a patch to have it removed
> from the tree?

I think we need it because of arch/ppc and how some headers are  
shared between it and arch/powerpc at this point.

- k
