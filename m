Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.229])
	by ozlabs.org (Postfix) with ESMTP id 9673EDDE2D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 07:40:50 +1100 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so1061202qbe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Feb 2008 12:40:49 -0800 (PST)
Message-ID: <fa686aa40802011240x3e22554bv8c40ba77ff042668@mail.gmail.com>
Date: Fri, 1 Feb 2008 13:40:48 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 2/7] [POWERPC] Xilinx: clear data caches.
In-Reply-To: <20071214003648.68E5EC68059@mail177-blu.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234240.F3CC3AD805D@mail122-sin.bigfish.com>
	<1197590848.15741.199.camel@pasglop>
	<1197590981.15741.201.camel@pasglop>
	<20071214003648.68E5EC68059@mail177-blu.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/13/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>
> Unfortunately, I think your right... The asm code seems so clean at the
> moment, I don't really want be the one to start tarnishing it with a
> bunch of little fixups.. :)

No problem, we can use a little shim that executes this stuff before
going into crt0.S.  I'm working on this right now.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
