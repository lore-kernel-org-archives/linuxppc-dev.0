Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72B152C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 09:42:23 +1100 (EST)
Date: Tue, 10 Dec 2013 14:20:09 +0100
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v6 00/17] add COMMON_CLK support for PowerPC MPC512x
Message-ID: <20131210132009.GR2982@book.gsilab.sittig.org>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385851897-23475-1-git-send-email-gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ trimmed Cc: list to PowerPC and CCF ]

On Sat, Nov 30, 2013 at 23:51 +0100, Gerhard Sittig wrote:
> 
> this series introduces support for the common clock framework (CCF,
> COMMON_CLK Kconfig option) in the PowerPC based MPC512x platform,
> which brings device tree based clock lookup as well

For the record:  MPC5125 turned out to be quite different
compared to MPC5121/5123 with regard to the set of peripherals
and clock features, so I sent an update of this COMMON_CLK
support motivated by MPC5125:

  From: Gerhard Sittig <gsi@denx.de>
  To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
    Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>,
    Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
  Cc: Scott Wood <scottwood@freescale.com>, Detlev Zundel <dzu@denx.de>,
    Gerhard Sittig <gsi@denx.de>
  Subject: [PATCH v1 0/4] powerpc/512x: update COMMON_CLK support for MPC5125
  Date: Tue, 10 Dec 2013 14:11:33 +0100
  Message-Id: <1386681097-14126-1-git-send-email-gsi@denx.de>


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
