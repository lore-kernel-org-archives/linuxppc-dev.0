Return-Path: <pebolle@tiscali.nl>
Received: from lb1-smtp-cloud6.xs4all.net (lb1-smtp-cloud6.xs4all.net
 [194.109.24.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C9D31A0611
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2015 02:47:21 +1000 (AEST)
Message-ID: <1436546836.20619.231.camel@tiscali.nl>
Subject: Re: [PATCH 03/11] soc/fsl: Introduce the DPAA BMan portal driver
From: Paul Bolle <pebolle@tiscali.nl>
To: Roy Pledge <roy.pledge@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Scott
 Wood <scottwood@freescale.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 10 Jul 2015 18:47:16 +0200
In-Reply-To: <BN3PR0301MB1267A318EF9DB3C193DA9FA08C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
 <1436473322-21247-4-git-send-email-Roy.Pledge@freescale.com>
 <1436535163.20619.216.camel@tiscali.nl>
 <BN3PR0301MB1267A318EF9DB3C193DA9FA08C9F0@BN3PR0301MB1267.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Roy,

On vr, 2015-07-10 at 15:19 +0000, Roy Pledge wrote:
> Thanks you for your valuable feedback so far.

You're welcome. Please note that I just scan for, well, common build
issues. Ie, stuff that requires no domain specific knowledge.

> Let me try to address a general issue you mention below: unused 
> exported APIs.

Good timing. I was pondering how to handle 04/11, a big patch that
exports 79 (!) symbols. Many of those appear to have no users.

> The QMan and BMan drivers provide a base layer for other blocks built 
> on top of them, for instance an Ethernet Driver, an Encrypt/Decrypt 
> Engine,  a pattern matcher, a compress/decompress engine, etc...
> Some of these drivers will be presented for review in the near future, 
> but in order to try and layer the review/up streaming process we're 
> presenting each layer as independently as possible.
> If you really were to start dissecting which APIs are called you would 
> come to a very small set of pieces that merely initialize the hardware 
> but don't provide any opportunity for other users to invoke that HW. 
> 
> I hope that this helps you understand our goals in trying to upstream 
> these drivers.

At the end of the day, what matters is what the people that need to sign
off on these drivers (ppc? netdev?) are comfortable with. I know that
some maintainers won't even bother looking at code that has no callers.

In the mean time I'll skip the exports for the remainder of this series.

Thanks,


Paul Bolle
