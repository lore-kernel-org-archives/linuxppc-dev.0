Return-Path: <rsiemsen@rossvideo.com>
Received: from server06.rossvideo.com (unknown [209.87.241.202])
	by ozlabs.org (Postfix) with ESMTP id A0B1C67A2C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Feb 2005 02:44:53 +1100 (EST)
Message-ID: <4200F296.4070100@rossvideo.com>
Date: Wed, 02 Feb 2005 10:32:38 -0500
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
References: <0007F077BB3476449151699150E8FEA205922F@exchange.tsi-telsys.com>
In-Reply-To: <0007F077BB3476449151699150E8FEA205922F@exchange.tsi-telsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How to enable TAH on PPC 440GX un lk 2.4.x?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sanjay Bajaj wrote:
> Please share any information on enabling TCP/IP Acceleration Hardware on IBM PPC 440GX processor based board.

Matt answered this question for you when you asked it on the 
linuxppc-embedded list last week.  There is no TAH support in 2.4, but 
the IBM EMAC ethernet driver 2.6 does support TAH mode.  You would need 
to backport this driver to use it with 2.4.  Nobody has done this work 
as far as I know, all of the current development effort is focused on 
2.6.  So your options are either to do the work to backport the driver, 
or else use 2.6.

Regards
-Ralph
