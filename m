Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 73986DDEE9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 03:17:58 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2626233wag
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 10:17:56 -0700 (PDT)
Message-ID: <fa686aa40710161017m7ab059eax70cdcdef325c2dd9@mail.gmail.com>
Date: Tue, 16 Oct 2007 11:17:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: Refactor booting-without-of.txt
In-Reply-To: <20071016171417.64605230209@mail24-fra.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
	<20071016171417.64605230209@mail24-fra.bigfish.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/16/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> On a similar note, is there interest in actually factoring the device
> tree code out from the different architectures into a common codebase?

It's already happened somewhat.  (Look in drivers/of and include/linux/of*.h)

However, I don't think any of the stuff specific to flattened device
trees is being factored out of arch/powerpc yet.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
