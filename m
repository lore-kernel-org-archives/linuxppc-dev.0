Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A88702C0097
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 20:08:22 +1000 (EST)
Message-ID: <51A72524.2060403@windriver.com>
Date: Thu, 30 May 2013 18:08:36 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: wolfking <wolfking2000@msn.com>
Subject: Re: can't access PCIe card under sbc8548
References: <1369885321567-71775.post@n7.nabble.com>
 <1369908140054-71817.post@n7.nabble.com>
In-Reply-To: <1369908140054-71817.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2013 06:02 PM, wolfking wrote:
> I tried several R/W functions: inb/outb and ioread8/iowrite8. The inb/outb

What about out_be32/in_be32?

Tiejun
