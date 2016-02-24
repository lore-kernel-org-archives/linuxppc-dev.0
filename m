Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 961F61A04EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 10:55:39 +1100 (AEDT)
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D9F58140778
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 10:55:38 +1100 (AEDT)
Received: by mail-pf0-x236.google.com with SMTP id x65so21673212pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 15:55:38 -0800 (PST)
Subject: Re: [PATCH 01/12] powerpc/module: Only try to generate the
 ftrace_caller() stub once
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE42F2.8080104@gmail.com>
Date: Thu, 25 Feb 2016 10:55:30 +1100
MIME-Version: 1.0
In-Reply-To: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/02/16 01:28, Michael Ellerman wrote:
> Currently we generate the module stub for ftrace_caller() at the bottom
> of apply_relocate_add(). However apply_relocate_add() is potentially
> called more than once per module, which means we will try to generate
> the ftrace_caller() stub multiple times.
This makes sense
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
