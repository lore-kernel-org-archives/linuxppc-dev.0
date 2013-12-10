Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 26B232C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 23:17:23 +1100 (EST)
Date: Tue, 10 Dec 2013 12:24:16 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, matteo.facchinetti@sirius-es.it
Subject: Re: [PATCH v1 1/1] powerpc/512x: dts: remove misplaced IRQ spec from
 'soc' node
Message-ID: <20131210112416.GQ2982@book.gsilab.sittig.org>
References: <1386068212-11484-1-git-send-email-gsi@denx.de>
 <20131203150432.2c326004@crub>
 <20131210100501.GO2982@book.gsilab.sittig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131210100501.GO2982@book.gsilab.sittig.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 10, 2013 at 11:05 +0100, Gerhard Sittig wrote:
> 
> FYI: I only noticed yesterday that MPC5125 suffers from the same
> issue, have sent <1386669068-2477-1-git-send-email-gsi@denx.de>
> to fix that as well.  Both patches may get squashed when going
> upstream.  Don't have a dump at hand for MPC5125 as I don't have
> access to hardware.

Had a thinko there, the MPC5121 fix already went upstream, while
the MPC5125 fix is pending.  So there is no squashing.  Nevermind.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
