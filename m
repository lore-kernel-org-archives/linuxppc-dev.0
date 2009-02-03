Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9BBF8DDFA9
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 20:03:47 +1100 (EST)
Subject: Re: [PATCH 3/3] drm: Make drm_local_map use a resource_size_t offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Airlie <airlied@gmail.com>
In-Reply-To: <21d7e9970902030039n786b831dm4395b802e0c87b45@mail.gmail.com>
References: <20090202055559.8D600DDF51@ozlabs.org>
	<1233608464.4932.15.camel@gaiman> <1233609688.18767.118.camel@pasglop>
	<21d7e9970902030039n786b831dm4395b802e0c87b45@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Feb 2009 20:02:00 +1100
Message-Id: <1233651720.16867.82.camel@pasglop>
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
	dri-devel@lists.sf.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Don't worry I've applied the patches with Erics comment replacing your one.
> 
> All 3 are queued in drm-next.

Thanks !

I'll let you know when I finally get a chance to tackle the other
issues.

BTW. Do you guys want me to remove the drm_local_map_t typedef
completely in favor of struct drm_local_map ? I have a patch here going
part way through that, it's fairly trivial, so if you want it, I can
easily finish it.

Cheers,
Ben.
