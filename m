Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B554A2C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 03:10:47 +1100 (EST)
Subject: Re: Clearing DBSR and DBCR0 in host handler.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D06FBE661@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Wed, 3 Apr 2013 11:10:36 -0500
Message-Id: <C62C333B-D3CA-4AE2-B9DF-39E3CF73A3C5@kernel.crashing.org>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D06FBE661@039-SN2MPN1-013.039d.mgd.msft.net>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 3, 2013, at 10:24 AM, Bhushan Bharat-R65777 wrote:

> Hi All,
>=20
> The kernel exception handling code for 32 bit (transfer_to_handler in =
entry_32.S) clear DBSR and load DBCR0 with 0 (global_dbcr0 variable, =
which is zero) if user space used debug (DBCR0.IDM set).
>=20
> But I do not same (clearing DBCR0 and DBSR) in 64bit exception =
handler. Is this an issue or I am missing something?
>=20
> Thanks
> -Bharat

Are you having a problem with debug w/the 64-bit kernel?  The 32-bit =
kernel supports several kernel level debug features that the 64-bit =
doesn't support.  So if you are having an issue that might be more =
helpful to convey that just asking about exception code path.

- k=
