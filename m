Return-Path: <john@phrozen.org>
Received: from nbd.name (unknown [IPv6:2a01:4f8:131:30e2::2])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8B398B6FBA
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2012 17:20:41 +1000 (EST)
Message-ID: <4FE1771A.8070703@phrozen.org>
Date: Wed, 20 Jun 2012 09:09:14 +0200
From: John Crispin <john@phrozen.org>
MIME-Version: 1.0
To: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120620152759.2caceb8c.yuasa@linux-mips.org>
In-Reply-To: <20120620152759.2caceb8c.yuasa@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/06/12 08:27, Yoichi Yuasa wrote:
> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
> 

Hi Yoichi,

I stumbled across the same build regression last night and came up with
almost the same fix :-)

Tested-by: John Crispin <blogic@openwrt.org>

Thanks,
John
