Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0143.outbound.protection.outlook.com [207.46.100.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C75C81A0729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 07:56:25 +1000 (AEST)
Message-ID: <1438034171.2993.313.camel@freescale.com>
Subject: Re: using srio in linux2.6.34.6  causes kernel panic
From: Scott Wood <scottwood@freescale.com>
To: liulijun <liulijun@ict.ac.cn>
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 27 Jul 2015 16:56:11 -0500
In-Reply-To: <2015072714264025850711@ict.ac.cn>
References: <2015072714264025850711@ict.ac.cn>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-27 at 14:26 +0800, liulijun wrote:
> I've been struggling with a kernel panic during enumeration of a Rapid IO 
> system.
> I am using the AM4140 with Freescale P4080 processor.  The Linux 
> kernel'version is 2.6.34.6.

That is a very old kernel.  If you're using that old kernel because it's a 
tree you got from some vendor, please contact them for assistance.  
Otherwise, please try again with the latest kernel.

-Scott
