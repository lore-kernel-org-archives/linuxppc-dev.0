Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0155.outbound.protection.outlook.com [207.46.163.155])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 15DA02C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 10:33:59 +1100 (EST)
Message-ID: <1391556825.6733.195.camel@snotra.buserror.net>
Subject: Re: Oops on shutdown : 3.11.0-5-powerpc-e500mc Ubuntu
From: Scott Wood <scottwood@freescale.com>
To: John Donnelly <john.d@servergy.com>
Date: Tue, 4 Feb 2014 17:33:45 -0600
In-Reply-To: <CAGtOQbRKZLzeup58X8rHz4YiF244TrkRXTqNv_57vEu2Rs8UNg@mail.gmail.com>
References: <CAGtOQbSJeJ85Nj-M2XB+w3p5+PTVWrpsFKZqCbEqZYkwsa0GGg@mail.gmail.com>
 <1391552655.6733.184.camel@snotra.buserror.net>
 <CAGtOQbRKZLzeup58X8rHz4YiF244TrkRXTqNv_57vEu2Rs8UNg@mail.gmail.com>
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

On Tue, 2014-02-04 at 16:45 -0600, John Donnelly wrote:
> Hi Scott,
> 
>  This panic was in the kernel related to NFS  , not u-boot;
>  Unfortunately I didn't catch the earlier console message/Oops  but I
> recall it being something similar.    
> 
> 
>  Can you enlighten me what the errata addresses ? I 
> 
> 
>  I filed the bug here:
> 
> 
> https://bugs.launchpad.net/ubuntu/+source/linux-ppc/+bug/1276290
> 
>  

>From the oops output it looks like you have force-loaded modules...  Are
you sure that isn't causing a problem?

-Scott
