Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 265321A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 18:48:33 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 13 Apr 2015 18:48:32 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E414A357804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 18:48:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3D8mK5447382556
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 18:48:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3D8lsPp022878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 18:47:55 +1000
Date: Mon, 13 Apr 2015 16:47:37 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the powerpc-mpe tree with the
 powerpc tree
Message-ID: <20150413084737.GA24116@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150413132715.2303253f@canb.auug.org.au>
 <20150413060913.GA2365@richard>
 <20150413175531.13d4ceb7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150413175531.13d4ceb7@canb.auug.org.au>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 13, 2015 at 05:55:31PM +1000, Stephen Rothwell wrote:
>Hi,
>
>On Mon, 13 Apr 2015 14:09:13 +0800 Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>>
>> Hi, Stephen,
>> 
>> Thanks for your finding :-) Your fix looks good to me.
>> 
>> Michael & Ben,
>> 
>> Do I need to rebase the patch or what should I do?
>
>You should have nothing to do, Michael has fixed it up when he merged
>Ben's tree into his.

OK, thanks :-)

>
>-- 
>Cheers,
>Stephen Rothwell                    sfr@canb.auug.org.au



-- 
Richard Yang
Help you, Help me
