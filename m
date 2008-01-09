Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D5E03DE02A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:52:36 +1100 (EST)
Date: Wed, 9 Jan 2008 10:02:00 -0600
From: Olof Johansson <olof@lixom.net>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
Message-ID: <20080109160200.GA10753@lixom.net>
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4784E78C.40904@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
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

But that's what this _accomplishes_. If linux needs something from the
firmware environment that it doesn't provide, it adds it itself. That
means that the firmware<>linux interface is no longer a moving target.

> If anyone wants to help/assist/suggest any updates to efika.forth,
> create binary tools which assist the installation of the script for
> users and for placement on Linux distro CDs etc. I would be very
> grateful, but it seems we have hit the Wall of Apathy where users
> complain for a feature but are not willing to work for it.

Amazing. Olaf just did that work for you, and he did it without providing
yet another tool for distros to pick up and maintain. And still you
complain. Is it really that strange that people aren't helping you out?!


-Olof
