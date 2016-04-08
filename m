Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0165.hostedemail.com
 [216.40.44.165])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhQSB40yKzDq6R
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:50:17 +1000 (AEST)
Message-ID: <1460134198.1800.37.camel@perches.com>
Subject: Re: [PATCH V2] mtd: nand: pasemi: switch to pr_* functions
From: Joe Perches <joe@perches.com>
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, Boris Brezillon
 <boris.brezillon@free-electrons.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, Egor
 Martovetsky <egor@pasemi.com>, Olof Johansson <olof@lixom.net>, David
 Woodhouse <dwmw2@infradead.org>,  Brian Norris
 <computersforpeace@gmail.com>, "open list:LINUX FOR POWERPC PA SEMI
 PWRFICIENT" <linuxppc-dev@lists.ozlabs.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Fri, 08 Apr 2016 09:49:58 -0700
In-Reply-To: <1460114003-19926-1-git-send-email-zajec5@gmail.com>
References: <1460111589-18781-1-git-send-email-zajec5@gmail.com>
 <1460114003-19926-1-git-send-email-zajec5@gmail.com>
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

On Fri, 2016-04-08 at 13:13 +0200, Rafał Miłecki wrote:
> 1) Use pr_fmt to keep messages consistent
> 2) Don't warn if kzalloc fails as it dumps stack on its own
> 3) Use %pR format for displaying whole resource to avoid:
> warning: format ‘%08llx’ expects type ‘long long unsigned int’, but
> argument 2 has type ‘resource_size_t’

thanks
