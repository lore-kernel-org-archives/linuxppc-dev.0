Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BD6EE2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 08:28:56 +1000 (EST)
Message-ID: <1347315917.11820.47.camel@pasglop>
Subject: RE: [PATCH] using get/put_user64 apis on 64bit machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Tue, 11 Sep 2012 08:25:17 +1000
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0646913C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1343038597-23859-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1347252129.2385.147.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0646913C@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-09-10 at 08:50 +0000, Bhushan Bharat-R65777 wrote:
> When I sent the patch I did not search the users, I agree that we can
> remove the __get_user64 and __put_user64 altogether.

Care to send a patch ?

Cheers,
Ben.
