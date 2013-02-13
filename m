Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 779342C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 07:09:33 +1100 (EST)
Message-ID: <1360786153.4852.91.camel@smoke>
Subject: Re: [PATCH 2/2] powerpc: Make context bits depend on virtual addr
 size.
From: Geoff Levand <geoff@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 13 Feb 2013 12:09:13 -0800
In-Reply-To: <87pq04jvb4.fsf@linux.vnet.ibm.com>
References: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360693905-23503-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360701185.2035.10.camel@pasglop> <87sj50kian.fsf@linux.vnet.ibm.com>
 <1360727211.2035.30.camel@pasglop> <87pq04jvb4.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: phileas-fogg@mail.ru, linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On Wed, 2013-02-13 at 17:10 +0530, Aneesh Kumar K.V wrote:
> Ok. How about the below patch. This is based on the suggestion from
> Paulus. I still have to take care of few comments in the code.
> 
> Phileas and Geoff,
> 
> Can we check whether this fix the PS3 boot hang ?

I did a quick build and boot test, and this one seems to work OK.

-Geoff
