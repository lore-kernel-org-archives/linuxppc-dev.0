Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zn3Q70htfzF10P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 16:51:42 +1100 (AEDT)
Received: by mail-wr0-x244.google.com with SMTP id s5so9336272wra.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 21:51:42 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 22 Feb 2018 06:51:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
Subject: Re: [PATCH v12 01/22] selftests/x86: Move protecton key selftest to
 arch neutral directory
Message-ID: <20180222055135.6m43xt3mt47sz37q@gmail.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-2-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519264541-7621-2-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Ram Pai <linuxram@us.ibm.com> wrote:

> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/Makefile           |    1 +
>  tools/testing/selftests/vm/pkey-helpers.h     |  223 ++++
>  tools/testing/selftests/vm/protection_keys.c  | 1407 +++++++++++++++++++++++++
>  tools/testing/selftests/x86/Makefile          |    2 +-
>  tools/testing/selftests/x86/pkey-helpers.h    |  223 ----
>  tools/testing/selftests/x86/protection_keys.c | 1407 -------------------------
>  6 files changed, 1632 insertions(+), 1631 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
>  create mode 100644 tools/testing/selftests/vm/protection_keys.c
>  delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
>  delete mode 100644 tools/testing/selftests/x86/protection_keys.c

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
