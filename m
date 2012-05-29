Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1875AB6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 04:02:20 +1000 (EST)
Message-ID: <4FC50F22.2040404@freescale.com>
Date: Tue, 29 May 2012 13:02:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anthony Foiani <tkil@scrye.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com>
In-Reply-To: <g7gvzbfhb.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/26/2012 01:53 AM, Anthony Foiani wrote:
> Li Yang-R58472 <r58472@freescale.com> writes:
> 
>> Thanks for bringing [CONFIG_MPC8315_DS] up again.  Looks like we do
>> have a problem here.
> 
> My impression is that the simplest fix is Adrian's patch, which simply
> keys off CONFIG_MPC831x_RDB.  It's not very satisfying, but I'll take
> "working" vs. "rare lockups at boot".

CONFIG_MPC831x_RDB doesn't mean that you're running on such a board,
only that the kernel supports those boards.  It should be a runtime test.

-Scott
