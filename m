Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f212.google.com (mail-gx0-f212.google.com
	[209.85.217.212]) by ozlabs.org (Postfix) with ESMTP id 6045EB7BDB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 17:07:42 +1100 (EST)
Received: by gxk4 with SMTP id 4so769034gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 22:07:40 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1260326706.16132.5.camel@pasglop>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<1260326706.16132.5.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 23:07:20 -0700
Message-ID: <fa686aa40912102207r24b37e2eh72ab0bd4225cc14a@mail.gmail.com>
Subject: Re: [PATCH] PowerPC: const intspec pointers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 8, 2009 at 7:45 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-12-08 at 13:39 +0100, Roman Fietze wrote:
>> Hello,
>>
>> Writing a driver using SCLPC on the MPC5200B I detected, that the
>> intspec arrays to map irqs to Linux virq cannot be const, because the
>> mapping and xlate functions only take non const pointers. All those
>> functions do not modify the intspec, so a const pointer could be used.
>>
>> I tried to compile that patch on different platforms and got no
>> compiler errors, so I'd like to ask you to review that patch, and
>> check if it's worth using it.
>
> Looks good.

Okay by me too.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
