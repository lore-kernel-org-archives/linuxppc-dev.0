Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E4CDB6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 01:19:01 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p61FIwsn028316
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2011 17:18:58 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Serial messages on boot
Date: Fri, 1 Jul 2011 17:18:57 +0200
References: <201107011606.50425.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201107011606.50425.dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107011718.57639.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> in the most recent versions of the [xilinx powerpc] kernel, there are no
> boot messages printed, which make it hard to debug early problems. What
> has changed and what can I do in order to get all the habitual boot
> messages on the serial port ?

My bad, as usual: wrong console in the dts file.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
