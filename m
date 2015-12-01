Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 015DA1A0707
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 20:48:11 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Rashmica Gupta <rashmicy@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, ben@codiert.org, thuth@redhat.com,
 mpe@ellerman.id.au
Subject: Re: [v2] powerpc/cell: Remove the Cell QPACE code
Date: Tue, 01 Dec 2015 10:42:15 +0100
Message-ID: <3097951.61mFBae0rW@wuerfel>
In-Reply-To: <1448941898-10123-1-git-send-email-rashmicy@gmail.com>
References: <1448941898-10123-1-git-send-email-rashmicy@gmail.com>
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

On Tuesday 01 December 2015 14:51:38 Rashmica Gupta wrote:
> All users of QPACE have upgraded to QPACE2 so remove the Cell QPACE code.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> ---
> Also removed the reference to QPACE in the Documentation.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
