Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 1A5D8DDFAE
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:33:09 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so110088uge.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 08:33:04 -0800 (PST)
Message-ID: <4784F803.9030003@genesi-usa.com>
Date: Wed, 09 Jan 2008 16:36:19 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sven Luther <sven@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<20080109153511.GA5086@powerlinux.fr>
	<4784F695.7050507@genesi-usa.com>
	<20080109162923.GA6290@powerlinux.fr>
In-Reply-To: <20080109162923.GA6290@powerlinux.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sven Luther wrote:
> On Wed, Jan 09, 2008 at 04:30:13PM +0000, Matt Sealey wrote:
>> Sven Luther wrote:
>>> Let's just fix this in the kernel, until we get a fixed efika firmware,
>>> then we can drop it easily enough. But until this happens, we need to be
>>> able to boot the kernel without any extra work on the users part.
>> That is exactly why I don't like the idea. Yes, it makes it easier for users
>> and easier for distro managers to say "it supports the Efika" but it makes
>> the Forth fixing, and any further firmware development (ignore the lack of
>> releases, it means nothing) much harder.
> 
> efika firmware development is dead. Until we see a release we should
> assume that the efika is a firmware with breakage, and no upstream

The link that Olaf presented, www.powerdeveloper.org/asset/by-id/46 *is*
the upstream support for now. What his patch does is say, the upstream
support exists, but we don't like it, so we will supplement the patch..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
