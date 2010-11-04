Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D4D0B6EED
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Nov 2010 07:58:07 +1100 (EST)
Subject: Re: Pb G4: Suspend-to-RAM doesn't work for aTi users
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jjDaNiMoTh <jjdanimoth@gmail.com>
In-Reply-To: <AANLkTimnxBrVoiyhrd3Sazwo++JCh7XfexDkcnqKX0dQ@mail.gmail.com>
References: <AANLkTimnxBrVoiyhrd3Sazwo++JCh7XfexDkcnqKX0dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Nov 2010 07:58:00 +1100
Message-ID: <1288904280.2147.1340.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-11-04 at 21:14 +0100, jjDaNiMoTh wrote:
> I read somewhere (ati-dri devel ml, maybe?) that suspend on aTi
> machines was broken with KMS, and I have exactly this problem. It is
> fixed now, so maybe I have some bad conf file? Or this feature isn't
> implemented yet?

Not implemented yet with KMS.

Cheers,
Ben.
