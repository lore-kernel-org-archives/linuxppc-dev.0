Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com
 [IPv6:2a00:1450:400c:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB8531A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 14:29:01 +1000 (AEST)
Received: by wgic8 with SMTP id c8so35026264wgi.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2015 21:28:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 May 2015 06:28:53 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] perf/kvm: Port perf kvm to powerpc
Message-ID: <20150508042853.GA24391@gmail.com>
References: <1431047266-6206-1-git-send-email-hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431047266-6206-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, paulus@samba.org, acme@kernel.org,
 warrier@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Hemant Kumar <hemant@linux.vnet.ibm.com> wrote:

>  # perf kvm stat report -p 60515
> Analyze events for pid(s) 60515, all VCPUs:
> 
>        VM-EXIT    Samples  Samples%     Time%    Min Time         Max        Time         Avg time
> 
> H_DATA_STORAGE       5006    35.30%     0.13%      1.94us     49.46us     12.37us ( +-   0.52% )
> HV_DECREMENTER       4457    31.43%     0.02%      0.72us     16.14us      1.91us ( +-   0.96% )
>        SYSCALL       2690    18.97%     0.10%      2.84us    528.24us     18.29us ( +-   3.75% )
> RETURN_TO_HOST       1789    12.61%    99.76%      1.58us 672791.91us  27470.23us ( +-   3.00% )
>       EXTERNAL        240     1.69%     0.00%        0.69us     10.67us      1.33us ( +-   5.34% )

Where is the last line misaligned? Copy & paste error or does perf kvm 
produce it in such a way?

Thanks,

	Ingo
