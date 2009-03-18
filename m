Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 90DDDDDDB2
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 08:00:02 +1100 (EST)
Date: Thu, 19 Mar 2009 00:00:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/4] powerpc/85xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090318210001.GA21512@oksana.dev.rtsoft.ru>
References: <20090318195911.GA31525@oksana.dev.rtsoft.ru>
	<20090318200039.GC8182@oksana.dev.rtsoft.ru>
	<49C1541F.8040803@freescale.com>
	<20090318202344.GA9708@oksana.dev.rtsoft.ru>
	<20090318202947.GA14504@oksana.dev.rtsoft.ru>
	<49C15A21.3050002@freescale.com>
	<20090318203327.GA15378@oksana.dev.rtsoft.ru>
	<49C15AFF.3050708@freescale.com>
	<20090318203928.GA16381@oksana.dev.rtsoft.ru>
	<49C15DB9.1050005@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <49C15DB9.1050005@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 03:46:49PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
>> I mean do you see any problem with giving Linux knowledge of
>> the -slave name?
>
> I guess I don't really see the point, compared with just having a naked  
> mdio node.  The power management issue in this case should be addressed  
> by ensuring that core0 never puts ethernet@24000 to sleep.

Amen.

If there'll be no further issues, I'll resend the patch set tomorrow.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
