Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2DDC67BD4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Dec 2006 17:47:59 +1100 (EST)
Subject: Re: Is in_le32 and out_le32 atomic?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <4579C586.5040809@grandegger.com>
References: <4579C586.5040809@grandegger.com>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 17:47:50 +1100
Message-Id: <1165819670.7260.38.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Can anybody tell me why the spin_* protection is needed? I thought that 
> 32-bit read and write operations are atomic.

It doesn't seem to make sense indeed...

Ben.
