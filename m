Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (216-161-111-230.roch.qwest.net
	[216.161.111.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 701296830B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 00:23:45 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Peter Fercher <peter.fercher@scs.ch>
In-Reply-To: <004f01c5bd21$394104e0$dbe5fed4@scsad.scs.ch>
References: <004f01c5bd21$394104e0$dbe5fed4@scsad.scs.ch>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 09:23:36 -0500
Message-Id: <1127139816.3211.4.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Cc: 'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: RE: emac driver broken in 2.6.12.2 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2005-09-19 at 15:51 +0200, Peter Fercher wrote:
> hi,
> 
> when you read the output I have pasted there you can see the following (also
> in my origninal mail)
<snip>
> 
> 
> I think that this MAC addresses are crap (sorry if not formulated clearly
> enough for you ;)
> am I wrong ?

No, you're not wrong.  My brain just didn't parse that as a problem with
the emac code itself.

Anyway, I think David and Stefan have pointed you in the right
direction.

josh
