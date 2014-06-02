Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B54311A05A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 02:46:12 +1000 (EST)
Message-ID: <1401727559.6603.227.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc/booke64: wrap tlb lock and search in htw
 miss with FTR_SMT
From: Scott Wood <scottwood@freescale.com>
To: Tudor Laurentiu <b10716@freescale.com>
Date: Mon, 2 Jun 2014 11:45:59 -0500
In-Reply-To: <538C7297.4040307@freescale.com>
References: <1401489946-12935-1-git-send-email-scottwood@freescale.com>
 <538C7297.4040307@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-02 at 15:48 +0300, Tudor Laurentiu wrote:
> On 05/31/2014 01:45 AM, Scott Wood wrote:
> > From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
> >   - resent since the original didn't make it to the list archives
> >     or patchwork.
> 
> The only thing i can think of is that maybe i've misspelled the mailing 
> list address ...

It looks right to me.  Did you get a bounce?

-Scott
