Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C97051A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 00:05:04 +1100 (AEDT)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4662C140187
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 00:05:04 +1100 (AEDT)
Received: by mail-pa0-x231.google.com with SMTP id fl4so14690477pad.0
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Mar 2016 05:05:04 -0800 (PST)
Subject: Re: [PATCH][v3] Enable livepatching on powerpc
To: linuxppc-dev@ozlabs.org
References: <1457009207-7080-1-git-send-email-bsingharora@gmail.com>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz,
 Torsten Duwe <duwe@suse.de>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56D83676.3060102@gmail.com>
Date: Fri, 4 Mar 2016 00:04:54 +1100
MIME-Version: 1.0
In-Reply-To: <1457009207-7080-1-git-send-email-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/03/16 23:46, Balbir Singh wrote:
> Changelog v3:
> 	1. Removed spurious kgdb patch
> 	2. Moved -ENOSYS to -EINVAL in klp_write_module_reloc
> 	3. Moved klp_matchaddr to use ftrace_location_range
>

Please ignore -- wrong patch!

Balbir
