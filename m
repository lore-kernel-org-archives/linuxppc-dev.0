Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQT1203fKzDq70
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 10:56:54 +1100 (AEDT)
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qQT113ZCvz9t3Y
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2016 10:56:53 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id 124so94661181pfg.0
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2016 16:56:53 -0700 (PDT)
Subject: Re: [v3,1/8] powerpc: Create a helper for getting the kernel toc value
To: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>
References: <3qNsms00H7z9snl@ozlabs.org>
 <alpine.LNX.2.00.1603150220231.3656@cbobk.fhfr.pm>
 <1458123799.27361.3.camel@ellerman.id.au> <20160316145851.GA15870@lst.de>
Cc: pmladek@suse.com, jeyu@redhat.com, Jiri Kosina <jikos@kernel.org>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56E9F2BD.2050504@gmail.com>
Date: Thu, 17 Mar 2016 10:56:45 +1100
MIME-Version: 1.0
In-Reply-To: <20160316145851.GA15870@lst.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 17/03/16 01:58, Torsten Duwe wrote:
> On Wed, Mar 16, 2016 at 09:23:19PM +1100, Michael Ellerman wrote:
>> Sure. I'll try and get something working, though this merge window is not
>> starting well so I may not get time for a few weeks :)
> Do you already have something in mind?
> Can you give us a hint?
>
>
We need extra space in the stack, it can be on top of the stack with a pointer in PACA, we could use a fixed set size stack for only LR restore, if required TOC restore, but I think we only need LR space

Balbir Singh.
