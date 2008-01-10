Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 17708DE045
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 22:46:10 +1100 (EST)
Date: Thu, 10 Jan 2008 12:46:28 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] add phy-handle property for fec_mpc52xx
Message-ID: <20080110114628.GA20988@aepfle.de>
References: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, sven@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, Grant Likely wrote:

> From: Olaf Hering <olaf@aepfle.de>
> 
> The new network driver fec_mpc52xx will not work on efika because the
> firmware does not provide all required properties.
> http://www.powerdeveloper.org/asset/by-id/46 has a Forth script to
> create more properties. But only the phy stuff is required to get a
> working network.
> 
> This should go into the kernel because its appearently
> impossible to boot the script via tftp and then load the real boot
> binary (yaboot or zimage).
> 
> (Olaf's s-o-b line needs to go here)
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>


Signed-off-by: Olaf Hering <olaf@aepfle.de>
