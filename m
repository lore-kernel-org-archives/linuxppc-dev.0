Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id E8B5DDDE26
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 09:00:16 +1000 (EST)
Date: Mon, 7 Apr 2008 17:59:49 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH 1/1 resend][PPC] replace logical by bitand in
	pci_process_ISA_OF_ranges(), arch/powerpc/kernel/isa-bridge.c
Message-ID: <20080407225949.GW7137@localdomain>
References: <47FA9FA6.8090201@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FA9FA6.8090201@tiscali.nl>
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roel Kluin wrote:
> replace logical by bit and for ISA_SPACE_MASK

I think Paul has picked this up now:

http://ozlabs.org/pipermail/linuxppc-dev/2008-April/054103.html
