Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 184E3DDE9C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 05:39:43 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2670967wag
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 12:39:42 -0700 (PDT)
Message-ID: <fa686aa40710161239w2103a3dch224024d3543a77f0@mail.gmail.com>
Date: Tue, 16 Oct 2007 13:39:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: Refactor booting-without-of.txt
In-Reply-To: <20071016172509.08B73FE0077@mail38-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
	<20071015165505.GA16040@lixom.net>
	<fa686aa40710151014q5e151ea9w3f589d9e89e95905@mail.gmail.com>
	<20071016023845.GK26787@localhost.localdomain>
	<fa686aa40710152002l5bb2c746i8174827e8d66c746@mail.gmail.com>
	<20071016032415.GO26787@localhost.localdomain>
	<20071016172509.08B73FE0077@mail38-dub.bigfish.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	microblaze-uclinux@itee.uq.edu.au,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/16/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> How about just 'device-tree', referring to any source, and then
> of-device-tree and flat-device-tree to document how the device tree is
> constructed.
> The fact that the API is poorly named is something that can always be
> fixed (and perhaps should be earlier rather than later).

It's not so much that it's poorly named; it's just historically named.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
