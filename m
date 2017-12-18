Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0tXF1jhRzDsFC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 07:52:45 +1100 (AEDT)
Subject: Re: ps3: Improve a size determination in five functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
 <7aed1208-aa55-edb6-54be-f47fb1498bfd@users.sourceforge.net>
 <128a40fe-0998-2d6c-ad56-e7b63fce7f12@infradead.org>
 <37ac8110-057a-9f07-841c-03e49d48f317@users.sourceforge.net>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <cfbfa255-697d-78fa-f9b6-483a4335f00b@infradead.org>
Date: Mon, 18 Dec 2017 12:52:35 -0800
MIME-Version: 1.0
In-Reply-To: <37ac8110-057a-9f07-841c-03e49d48f317@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/18/2017 12:45 PM, SF Markus Elfring wrote:
>> but you are also removing empty lines and changing the coding format.
> 
> * Why do you not like such a change combination?
> 
> * Do you really want to integrate further update steps in this case?

I want to keep the coding style consistent throughout the file.

-Geoff
