Return-Path: <sebastian.huber@embedded-brains.de>
Received: from dedi548.your-server.de (dedi548.your-server.de [85.10.215.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJLmj5Wc0zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 20:56:53 +1100 (AEDT)
Subject: Re: [PATCH] soc/qbman: Simplify bman_release()
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Madalin Bucur <madalin.bucur@nxp.com>
References: <20170710072859.2616-1-sebastian.huber@embedded-brains.de>
Message-ID: <f25ecaec-1a78-7b72-1ed0-45d0a818e9bb@embedded-brains.de>
Date: Fri, 20 Oct 2017 11:35:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170710072859.2616-1-sebastian.huber@embedded-brains.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping.

On 10/07/17 09:28, Sebastian Huber wrote:
> Get the affine portal only once for the complete transaction.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

--=20
Sebastian Huber, embedded brains GmbH

Address : Dornierstr. 4, D-82178 Puchheim, Germany
Phone   : +49 89 189 47 41-16
Fax     : +49 89 189 47 41-09
E-Mail  : sebastian.huber@embedded-brains.de
PGP     : Public key available on request.

Diese Nachricht ist keine gesch=C3=A4ftliche Mitteilung im Sinne des EHUG=
.
