Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z274N3SwLzDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 08:21:24 +1100 (AEDT)
Subject: Re: ps3: Improve a size determination in five functions
To: Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
 <7aed1208-aa55-edb6-54be-f47fb1498bfd@users.sourceforge.net>
 <cd0c8519-85d0-0ce5-14a1-54a573234a98@infradead.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <2003adbe-1849-b689-40bf-00e02ae4e01e@users.sourceforge.net>
Date: Wed, 20 Dec 2017 22:20:36 +0100
MIME-Version: 1.0
In-Reply-To: <cd0c8519-85d0-0ce5-14a1-54a573234a98@infradead.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Some observations:
> 
>  o Your patch fixes no bug nor replaces any depreciated feature.

How do you think about information from the section “14) Allocating memory”
in the document “coding-style.rst” for the shown source code transformation?


>  o There will be no functional change; …

Yes. - The suggested adjustment should work in this way generally.

Regards,
Markus
