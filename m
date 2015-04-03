Return-Path: <pebolle@tiscali.nl>
Received: from lb3-smtp-cloud3.xs4all.net (lb3-smtp-cloud3.xs4all.net
 [194.109.24.30])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B01E21A0A3F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 08:31:09 +1100 (AEDT)
Message-ID: <1428096660.7898.27.camel@x220>
Subject: Re: [PATCH v2] powerpc/83xx: add support for mpc8306
From: Paul Bolle <pebolle@tiscali.nl>
To: Filip =?UTF-8?Q?Brozovi=C4=87?= <fbrozovic@gmail.com>
Date: Fri, 03 Apr 2015 23:31:00 +0200
In-Reply-To: <551E8B65.5010400@gmail.com>
References: <1428057856-26421-1-git-send-email-fbrozovic@gmail.com>
 <1428062487.7898.12.camel@x220> <551E8B65.5010400@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-03 at 14:45 +0200, Filip Brozović wrote:
> The idea was that boards in the Kconfig file would select these symbols 
> in order to enable support for the 8306. I mainly wanted to get this 
> patch into mainline in order to make kernel maintenance for a couple of 
> custom in-house developed boards easier.

The trouble with this patch is that, without some follow up patch, it
adds Kconfig symbols and preprocessor checks that are pointless for
mainline. I think we should not do that. (I'm also not sure how having
those bits in mainline substantially benefits out of tree development.)

But if you would put this in a series that also adds the code using
these bits, than I'd have no reason to object (and neither would, I
guess, the bots checking the tree for issues like that).

Thanks,


Paul Bolle
