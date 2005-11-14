Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 738D468748
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Nov 2005 08:03:40 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
In-Reply-To: <17272.46529.847423.310952@alkaid.it.uu.se>
References: <17272.46529.847423.310952@alkaid.it.uu.se>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 08:03:00 +1100
Message-Id: <1132002180.5504.206.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1 fails to boot on eMac
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-14 at 17:05 +0100, Mikael Pettersson wrote:
> Linux kernel 2.6.15-rc1 (vanilla, not patched, compiled with
> gcc-3.4.4) refuses to boot on my Apple eMac (1.25GHz G4). After
> yaboot has loaded the kernel the output on the console is:

Yup, there is something wrong, I'm still investigating.

Ben.
