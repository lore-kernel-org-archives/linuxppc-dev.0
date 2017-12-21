Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2Bk15qSDzDsPn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 11:05:45 +1100 (AEDT)
Subject: Re: ps3: Improve a size determination in five functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
 <7aed1208-aa55-edb6-54be-f47fb1498bfd@users.sourceforge.net>
 <cd0c8519-85d0-0ce5-14a1-54a573234a98@infradead.org>
 <2003adbe-1849-b689-40bf-00e02ae4e01e@users.sourceforge.net>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <d67137c4-5fa7-bb3a-fc38-4d50ceed02cd@infradead.org>
Date: Wed, 20 Dec 2017 16:05:33 -0800
MIME-Version: 1.0
In-Reply-To: <2003adbe-1849-b689-40bf-00e02ae4e01e@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/20/2017 01:20 PM, SF Markus Elfring wrote:
>>  o Your patch fixes no bug nor replaces any depreciated feature.
> 
> How do you think about information from the section “14) Allocating memory”
> in the document “coding-style.rst” for the shown source code transformation?

In terms of importance, I would put maintenance and user support as more
important than coding style.

Regarding Section 14 of coding-style.rst specifically, as I mentioned the
PS3 support is over 10 years old.  I don't expect a change to the type of
any structures.  If there are type changes, then we can update the
allocation size parameters at that time.

-Geoff
