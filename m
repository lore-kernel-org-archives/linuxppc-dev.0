Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3DA11DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 03:42:15 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m46HfZFt017057
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 13:41:35 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m46HfZRN1075846
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 13:41:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m46HfYZ3018305
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 13:41:35 -0400
Date: Tue, 6 May 2008 12:40:22 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 1/4] [v4][POWERPC] refactor dcr code
Message-ID: <20080506124022.708627c2@zod.rchland.ibm.com>
In-Reply-To: <20080506173438.5C1A0820071@mail178-dub.bigfish.com>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.5C26F2B0059@mail60-sin.bigfish.com>
	<20080506134006.62900cce.sfr@canb.auug.org.au>
	<1210046531.21644.139.camel@pasglop>
	<20080506173438.5C1A0820071@mail178-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 6 May 2008 10:34:36 -0700
"Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com> wrote:

> 
> I'll fix it.

Great.  Otherwise the patch looks pretty good in my review.  I'll queue
it up for 2.6.27.

josh
