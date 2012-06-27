Return-Path: <rientjes@google.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F7D9B6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 16:10:36 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so1242809pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jun 2012 23:10:34 -0700 (PDT)
Date: Tue, 26 Jun 2012 23:10:32 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH 1/12] memory-hotplug : rename remove_memory to
 offline_memory
In-Reply-To: <4FEA9D5C.1080508@jp.fujitsu.com>
Message-ID: <alpine.DEB.2.00.1206262309301.32567@chino.kir.corp.google.com>
References: <4FEA9C88.1070800@jp.fujitsu.com> <4FEA9D5C.1080508@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jun 2012, Yasuaki Ishimatsu wrote:

> remove_memory() does not remove memory but just offlines memory. The patch
> changes name of it to offline_memory().
> 

The kernel is never going to physically remove the memory itself, so I 
don't see the big problem with calling it remove_memory().  If you're 
going to change it to offline_memory(), which is just as good but not 
better, then I'd suggest changing add_memory() to online_memory() for 
completeness.
