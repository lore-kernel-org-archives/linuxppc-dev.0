Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 26355B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 09:18:54 +1000 (EST)
Message-ID: <4A6E3302.9030701@consentry.com>
Date: Mon, 27 Jul 2009 16:06:42 -0700
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, vijay sharma <vjai22@gmail.com>
Subject: Subject: Re: PPCboot and latest kernel
References: <mailman.23.1248732967.30868.linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <mailman.23.1248732967.30868.linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vijay sharma wrote:
> Linux/PowerPC load:
> Finalizing device tree... flat tree at 0x2f65300 <== Beyond this point no
> output is available.

I have found that on my MPC8272 system running 2.6.28 & cuImage, the
/chosen/linux,stdout-path node is respected by the boot wrapper, but the
main kernel always uses the first serial port mentioned in the device
tree as the console.  If you have multiple serial ports in your .dts,
try re-ordering them.

					-=] Mike [=-
