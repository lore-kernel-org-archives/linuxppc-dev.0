Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D35F2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 09:24:33 +1100 (EST)
Message-ID: <1391552655.6733.184.camel@snotra.buserror.net>
Subject: Re: Oops on shutdown : 3.11.0-5-powerpc-e500mc Ubuntu
From: Scott Wood <scottwood@freescale.com>
To: John Donnelly <john.d@servergy.com>
Date: Tue, 4 Feb 2014 16:24:15 -0600
In-Reply-To: <CAGtOQbSJeJ85Nj-M2XB+w3p5+PTVWrpsFKZqCbEqZYkwsa0GGg@mail.gmail.com>
References: <CAGtOQbSJeJ85Nj-M2XB+w3p5+PTVWrpsFKZqCbEqZYkwsa0GGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-04 at 08:47 -0600, John Donnelly wrote:
> 
> 
> 
> 
> Hi,
>  Where is a appropriate place to file a bug for this : This is the
> second occurrence I have seen.
> 
What U-Boot are you running, and what is the output of its "errata"
command?  There are some errata (e.g. A-004510) that can cause random
corruption if you don't have the workaround.

Were both crashes similar (same part of the code, same circumstances)?

-Scott
