Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 902D41A025C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:30:40 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 thuth@redhat.com
Subject: Re: [PATCH 1/6] powerpc/kconfig: Move NR_IRQS into "Kernel Options"
Date: Thu, 08 Oct 2015 23:30:27 +0200
Message-ID: <7826129.RXlL8kStvO@wuerfel>
In-Reply-To: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 09 October 2015 08:09:12 Michael Ellerman wrote:
> Currently the NR_IRQS option sits at the top level, which is ugly in
> menuconfig. It's not something users will commonly need to worry about
> so move it into "Kernel Options".
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 

Is this option actually still meaningful at all, when you select CONFIG_SPARSE_IRQ
unconditionally?

	Arnd
