Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 90619DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Feb 2008 03:23:18 +1100 (EST)
Message-ID: <47B5BC1E.3090707@scram.de>
Date: Fri, 15 Feb 2008 17:21:50 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: HDLC driver - dev_free_skb_irq causes Segfault
References: <00be01c86b8d$27c2fcb0$6405a8c0@absolut>
In-Reply-To: <00be01c86b8d$27c2fcb0$6405a8c0@absolut>
Content-Type: text/plain; charset=windows-1252
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

Hi Russell,

> ‘Unable to Handle Kernel Paging Request for data at address 0x00000000’

You need to check where the crash happens and what data is 0.

> Anyone have any ideas?

Is the source of this driver available somewhere?

Thanks,
Jochen
