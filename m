Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id A50B4DE024
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:35:12 +1100 (EST)
Date: Wed, 9 Jan 2008 16:35:11 +0100
From: Sven Luther <sven@genesi-usa.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
Message-ID: <20080109153511.GA5086@powerlinux.fr>
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4784E78C.40904@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, sven@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 03:26:04PM +0000, Matt Sealey wrote:
> Clarification: I really have to disagree with this patch, and Sven.
> 
> The whole point of removing the stuff from the Linux kernel (as the
> efika.forth script and the associated patch performs) is that it means
> the Linux kernel is no longer a "moving target" for our firmware
> development.

What firmware development ? 

> If users require these kernels they can run efika.forth - the major
> stumbling block being this is quite ugly to do right now. This is our
> problem - bplan, Genesi, myself whoever you want to target - it should
> not be made into a Linux problem by creating this "moving target" that
> needs constant patching to maintain driver coherency.

Then get the firmware fixed, and everyone would be happy. I don't see
that happening in the near future, just as there has been no pegasos
firmware release in ages, and my work on it has been scratched, and
ignored for the efika firmware which has lot of regression compared to
the latest pegasos beta releases.

A new efika firmware upgrade has been promised in, what was it, marsch
last year or so, where is it ? 

Let's just fix this in the kernel, until we get a fixed efika firmware,
then we can drop it easily enough. But until this happens, we need to be
able to boot the kernel without any extra work on the users part.

Friendly,

Sven Luther
