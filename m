Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjxr20Y3yzDq9n
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:27:46 +1000 (AEST)
Message-ID: <1460348865.3444.0.camel@ellerman.id.au>
Subject: Re: cxl: fix setting of _PAGE_USER bit when handling page faults
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Date: Mon, 11 Apr 2016 14:27:45 +1000
In-Reply-To: <570B23CD.3090203@au1.ibm.com>
References: <3qWf364wYxz9sDG@ozlabs.org> <8737rau3b7.fsf@linux.vnet.ibm.com>
 <570B23CD.3090203@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-11 at 14:10 +1000, Andrew Donnellan wrote:
> On 29/03/16 00:42, Aneesh Kumar K.V wrote:
> > I noticed this when doing radix support and have a variant posted at
> > 
> > https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-March/141036.html
> 
> I'm happy for this to be fixed in your radix series.

I'm not :)

This needs a stand-alone fix that we can backport.

cheers
