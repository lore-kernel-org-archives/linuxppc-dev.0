Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 61E34DDFC9
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 16:58:07 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so3305506ywh.39
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jan 2009 21:58:05 -0800 (PST)
Message-ID: <fa686aa40901112158o5a0d0c73pfbd67825096cca99@mail.gmail.com>
Date: Sun, 11 Jan 2009 22:58:05 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
In-Reply-To: <1231736850.22571.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20090107135457.234150@gmx.net> <20090107140132.140980@gmx.net>
	<fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>
	<1231736850.22571.17.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 11, 2009 at 10:07 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2009-01-07 at 09:41 -0700, Grant Likely wrote:
>> For the flattened device tree, I think we've settled on the convention
>> that every node with an IRQ connection should have both the
>> interrupt-parent and interrupts properties.  (ie. don't rely on the
>> parent node's interrupt-parent property.)
>
> Ah ? I use the trick of relying on the parent node regulary :-) Where
> did we discuss that ?

It is also entirely possible that I'm smoking something exotic.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
