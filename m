Return-Path: <simon.jeons@gmail.com>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FE9C2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2013 11:35:27 +1100 (EST)
Received: by mail-pb0-f50.google.com with SMTP id wz7so5041896pbc.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 16:35:25 -0800 (PST)
Message-ID: <1358987715.3351.3.camel@kernel>
Subject: Re: [PATCH Bug fix 0/5] Bug fix for physical memory hot-remove.
From: Simon Jeons <simon.jeons@gmail.com>
To: Tang Chen <tangchen@cn.fujitsu.com>
Date: Wed, 23 Jan 2013 18:35:15 -0600
In-Reply-To: <50FFE2FC.9030401@cn.fujitsu.com>
References: <1358854984-6073-1-git-send-email-tangchen@cn.fujitsu.com>
 <1358944171.3351.1.camel@kernel> <50FFE2FC.9030401@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm@kvack.org, paulus@samba.org, hpa@zytor.com, cl@linux.com,
 sfr@canb.auug.org.au, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, julian.calaby@gmail.com,
 glommer@parallels.com, wujianguo@huawei.com, yinghai@kernel.org,
 laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-01-23 at 21:17 +0800, Tang Chen wrote:
> On 01/23/2013 08:29 PM, Simon Jeons wrote:
> > Hi Tang,
> >
> > I remember your big physical memory hot-remove patchset has already
> > merged by Andrew, but where I can find it? Could you give me git tree
> > address?
> 
> Hi Simon,
> 
> You can find all the physical memory hot-remove patches and related bugfix
> patches from the following url:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm

~/linux-next$ git remote -v
origin git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(fetch)
origin git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(push)
~/linux-next$ git branch
* akpm
  master
~/linux-next$ wc -l mm/memory_hotplug.c 
1173 mm/memory_hotplug.c

I still can't find it. :(

> 
> 
> Thanks. :)
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
