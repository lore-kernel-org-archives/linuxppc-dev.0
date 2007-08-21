Return-Path: <matt@genesi-usa.com>
Message-ID: <46CACAAE.5000304@genesi-usa.com>
Date: Tue, 21 Aug 2007 12:21:18 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>,  linuxppc-embedded@ozlabs.org
Subject: Re: OF /chosen/initrd,* variables - patch, official?
References: <46CAC89F.2040100@genesi-usa.com>
In-Reply-To: <46CAC89F.2040100@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Damn, I should use patchwork more efficiently;

http://patchwork.ozlabs.org/linuxppc/patch?q=initrd&filter=none&id=12168

Does anyone have any suggestion on the best way to integrate this so that
it "just works" on OF platforms? It seems only to be usable way too late
in boot to work, this code would have to be called in boot/main.c which seems
relatively.. impossible to achieve.. or called in some specialised platform
init code..

I hacked up a patch initially before I saw Milton's work and did it all
in main.c (and did the same to mkvmlinuz..) and it seemed to work okay
there.

I'm really curious as to the status and usefulness of this here.. :(

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Matt Sealey wrote:
> Hi guys,
> 
> Just a query here, there was a patch for /chosen/initrd,start and initrd,end
> variables gained from firmware or so, which allowed booting without getting
> those values into r3/r4, does anyone know the maintainer/author of that
> patch?
> 
> Also, what are the chances of pushing it for 2.6.23 or 2.6.24? I can imagine
> it's fairly useful (at least it is to me)..
> 
