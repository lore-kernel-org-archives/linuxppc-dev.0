Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] Add MPC52xx PIO/ATA support for arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <200611041504.kA4F4Ll1029368@post.webmailer.de>
References: <200611041504.kA4F4Ll1029368@post.webmailer.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 12:27:20 +1100
Message-Id: <1162690040.28571.126.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	sl@bplqn-gmbh.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-04 at 16:04 +0100, Nicolas DET wrote:
> This patch add MPC52xx ATA/PIO support.
> 
> It's based on a previous patch:
> http://patchwork.ozlabs.org/linuxppc/patch?id=4364
> 
> But, it now use of_platform and a of_device_id to match the appropriate device.
> 
> Signed-off-by: Nicolas DET <nd@bplqn-gmbh.de>

Very quick look, seems good to me. (Well, the fact that I wrote the
original version of it might help ! hehehe...)

Could you post it to linux-ide though in case somebody else spots
something wrong ?

I think it can go in 2.6.20 along with the rest of your platform support
(once the later is finally ready to go, hopefully soon).

Ben.
