Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6343B1A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 12:56:40 +1100 (AEDT)
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D4DDA140D86
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 12:56:39 +1100 (AEDT)
Received: by mail-pa0-x22b.google.com with SMTP id fl4so25266900pad.0
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Mar 2016 17:56:38 -0800 (PST)
Subject: Re: [PATCH v3 1/8] powerpc: Create a helper for getting the kernel
 toc value
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56D8EB49.8090200@gmail.com>
Date: Fri, 4 Mar 2016 12:56:25 +1100
MIME-Version: 1.0
In-Reply-To: <1456979220-10931-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/03/16 15:26, Michael Ellerman wrote:
> Move the logic to work out the kernel toc pointer into a header. This is
> a good cleanup, and also means we can use it elsewhere in future.
>
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Reviewed-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir
