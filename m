Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWZ7V1Bc3zDqjD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 18:07:17 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id i186so5851315wmi.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 23:07:17 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 31 Jan 2018 08:07:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
 arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Subject: Re: [PATCH v11 0/3] mm, x86, powerpc: Enhancements to Memory
 Protection Keys.
Message-ID: <20180131070711.pad45qmnougnh4vf@gmail.com>
References: <1517341452-11924-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517341452-11924-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Ram Pai <linuxram@us.ibm.com> wrote:

> This patch series provides arch-neutral enhancements to
> enable memory-keys on new architecutes, and the corresponding
> changes in x86 and powerpc specific code to support that.
> 
> a) Provides ability to support upto 32 keys.  PowerPC
> 	can handle 32 keys and hence needs this.
> 
> b) Arch-neutral code; and not the arch-specific code,
>    determines the format of the string, that displays the key
>    for each vma in smaps.
> 
> PowerPC implementation of memory-keys is now in powerpc/next tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=92e3da3cf193fd27996909956c12a23c0333da44

All three patches look sane to me. If you would like to carry these generic bits 
in the PowerPC tree as well then:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
