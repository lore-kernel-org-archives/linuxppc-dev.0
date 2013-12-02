Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 153212C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 20:53:45 +1100 (EST)
Subject: Re: ping: re: [PATCH 1/1] kernel code that do not handle NULL return
 of kmem_cache_zalloc
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <e9c283.a967.142b14600da.Coremail.yizhouzhou@ict.ac.cn>
Date: Mon, 2 Dec 2013 10:54:51 +0100
Message-Id: <65B0AD57-F44C-4360-916C-16D26884B09C@suse.de>
References: <1385549465-15945-1-git-send-email-yizhouzhou@ict.ac.cn>
 <e9c283.a967.142b14600da.Coremail.yizhouzhou@ict.ac.cn>
To: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
Cc: "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 Zhouyi Zhou <zhouzhouyi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.12.2013, at 04:07, Zhouyi Zhou <yizhouzhou@ict.ac.cn> wrote:

> ping
>>  I do a grep for kmem_cache_zalloc and kmem_cache_alloc
>>  in kernel tree, and find some code do not handle NULL
>>  return of kmem_cache_zalloc correctly
>> =20
>> =20
>>  Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>

Thanks a lot for the patch. I'd assume we want something slightly more =
clever even, similar to Paul's d78bca729.

Please beware that it's usually not a good idea to post patches that =
span multiple subtrees. I don't want to apply a patch to my kvm tree =
that touches jffs2 for example, as that's out of my scope. It usually =
makes a maintainer's life easier if you split up a patch like this =
according to tree responsibilities.


Alex
