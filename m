Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1714B1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:37:01 +1100 (AEDT)
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 61741140291
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:37:00 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id c10so26473683pfc.2
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2016 20:37:00 -0800 (PST)
Subject: Re: [PATCH 01/12] powerpc/module: Only try to generate the
 ftrace_caller() stub once
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <56CE42F2.8080104@gmail.com>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CE84E4.6020900@gmail.com>
Date: Thu, 25 Feb 2016 15:36:52 +1100
MIME-Version: 1.0
In-Reply-To: <56CE42F2.8080104@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 25/02/16 10:55, Balbir Singh wrote:
>
> On 25/02/16 01:28, Michael Ellerman wrote:
>> Currently we generate the module stub for ftrace_caller() at the bottom
>> of apply_relocate_add(). However apply_relocate_add() is potentially
>> called more than once per module, which means we will try to generate
>> the ftrace_caller() stub multiple times.
> This makes sense
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
For the entire series also

Tested-by: Balbir Singh <bsingharora@gmail.com>
