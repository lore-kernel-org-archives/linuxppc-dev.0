Return-Path: <jgpobox@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF92F1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 12:45:09 +1100 (EST)
Received: by vcbfl13 with SMTP id fl13so1320662vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 17:45:06 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4F162420.9020302@pobox.com>
Date: Tue, 17 Jan 2012 20:45:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Liu Qiang-B32616 <B32616@freescale.com>
Subject: Re: [PATCH][SDK v1.2] sata: I/O load balancing
References: <1326443147-26645-1-git-send-email-qiang.liu@freescale.com>,
 <CADRPPNQsVB-2jR0UaX6RB_4PCf9kt4UXvAXnxaVk=LsBcwGowg@mail.gmail.com>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB701320C@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB701320C@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2012 04:57 AM, Liu Qiang-B32616 wrote:
> No, I didn't test small file. I think this won't affect system load. I can have a test
> and describe the result in next patch.

Please do...
