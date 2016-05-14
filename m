Return-Path: <danielwa@cisco.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r67V70Mw0zDq8G
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 May 2016 10:52:15 +1000 (AEST)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 (using TLSv1.2 with cipher DHE-RSA-SEED-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r67V6251Wz9t5s
 for <linuxppc-dev@ozlabs.org>; Sat, 14 May 2016 10:52:14 +1000 (AEST)
To: linuxppc-dev@ozlabs.org,
 "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>,
 Kumar Gala <galak@kernel.crashing.org>
From: Daniel Walker <danielwa@cisco.com>
Subject: udgb on fsl booke?
Message-ID: <57367455.5060306@cisco.com>
Date: Fri, 13 May 2016 17:41:57 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

I noticed that udbg is missing for fsl booke , or at least it doesn't 
appear to be implemented. I don't know a great deal about fsl book. I'm 
working on an MCP85XX at the moment , and I was looking into the udbg 
system to get prints. It looks like fsl booke might be similar enough to 
44x to use the already implemented udbg routines for that.

Does anyone have suggestion on this ? Is fsl booke missing because it's 
not possible to have this, or no one ever needed it ?

Thanks,

Daniel
