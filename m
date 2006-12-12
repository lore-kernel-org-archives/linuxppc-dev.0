Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 481DB67C84
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 06:56:14 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 michael@ellerman.id.au
Subject: Re: [PATCH 12/15] powerpc: Do not use op_model_cell under LPAR
Date: Tue, 12 Dec 2006 20:55:59 +0100
References: <200612120402.kBC42USg007674@toshiba.co.jp>
	<1165896791.14839.7.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1165896791.14839.7.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612122055.59698.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 December 2006 05:13, Michael Ellerman wrote:
>   On Tue, 2006-12-12 at 13:02 +0900, Ishizaki Kou wrote:
> > op_model_cell supports native Cell processor. Under LPAR environment,
> > it cannot work.
> > 
> > Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

> 
> Is FW_FEATURE_LPAR is the right switch to use here, I'm not sure.

Yes, I think it is. The code accesses I/O memory areas that can not
work under any hypervisor, so FW_FEATURE_LPAR makes perfect sense
to me.

	Arnd <><
