Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYSCd616WzDvj3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 16:46:04 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB75jBcO073828
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 00:46:00 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2763yc5xfx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 00:45:59 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 7 Dec 2016 15:45:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2E2732BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 16:45:56 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB75juwo62718106
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 16:45:56 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB75jtd3023752
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Dec 2016 16:45:55 +1100
Subject: Re: [PATCH 3/3] powerpc: enable support for GCC plugins
To: linuxppc-dev@lists.ozlabs.org, kernel-hardening@lists.openwall.com,
 keescook@chromium.org, re.emese@gmail.com
References: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
 <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
Cc: pageexec@freemail.hu, spender@grsecurity.net, linux-kernel@vger.kernel.org,
 mmarek@suse.com, linux-kbuild@vger.kernel.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 7 Dec 2016 16:45:54 +1100
MIME-Version: 1.0
In-Reply-To: <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d7861b43-cda8-0212-b2fb-7331c8f6996d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/12/16 17:28, Andrew Donnellan wrote:
> Enable support for GCC plugins on powerpc.
>
> Add an additional version check in gcc-plugins-check to advise users to
> upgrade to gcc 5.2+ on powerpc to avoid issues with header files (gcc <=
> 4.6) or missing copies of rs6000-cpus.def (4.8 to 5.1 on 64-bit targets).
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---
>
> Open to bikeshedding on the gcc version check.
>
> Compile tested with all plugins enabled on gcc 4.6-6.2,
> x86->ppc{32,64,64le} and 4.8-6.2 ppc64le->ppc{32,64,64le}. Thanks to
> Chris Smart for help with this.
>
> I think it's best to take this through powerpc#next with an ACK from
> Kees/Emese?
> ---
>  arch/powerpc/Kconfig         | 1 +
>  scripts/Makefile.gcc-plugins | 8 ++++++++

Will respin with an update to Documentation/gcc-plugins.txt as well.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
