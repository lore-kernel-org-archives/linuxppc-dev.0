Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 102081A0352
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 10:20:01 +1100 (AEDT)
Received: from mail-pf0-f173.google.com (mail-pf0-f173.google.com
 [209.85.192.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 72F761402BC
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 10:20:00 +1100 (AEDT)
Received: by mail-pf0-f173.google.com with SMTP id q63so40685470pfb.0
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:20:00 -0800 (PST)
Received: from cotter.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id ss5sm14573387pab.15.2016.02.25.15.19.57
 for <linuxppc-dev@ozlabs.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 25 Feb 2016 15:19:58 -0800 (PST)
Resent-Message-ID: <56CF8C1A.8080105@gmail.com>
Date: Thu, 25 Feb 2016 20:12:49 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, duwe@lst.de, jkosina@suse.cz, mbenes@suse.cz,
 pmladek@suse.com, jeyu@redhat.com, rostedt@goodmis.org,
 live-patching@vger.kernel.org, Torsten Duwe <duwe@suse.de>
Subject: Re: [RFC][PATCH] Enable livepatching for powerpc
Message-ID: <20160225144248.GA7539@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1456402305-1612-1-git-send-email-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1456402305-1612-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Balbir Singh <bsingharora@gmail.com> [2016-02-25 23:11:45]:

> This applies on top of the patches posted by Michael today
> Enable livepatching. This takes patch 6/8 and 7/8 of v8 as the base.
> Removes the extra strict check in gcc-profile-kernel-notrace.sh
> and adds logic for checking offsets in livepatch. The patch
> for HAVE_C_RECORDMCOUNT is not required and not used here.
> 
> Depending on whether or not a TOC is generated, the offset
> for _mcount can be +16 or +8. The changes are such that the
> offset checks are specific to powerpc.
> 
> Comments? Testing? I tested the sample in the livepatch
> directory
> 
> References
> 
> 1. https://patchwork.ozlabs.org/patch/581521/
> 2. https://patchwork.ozlabs.org/patch/587464/
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

I was able to test livepatch-sample module with this patch + Michael patch set.

Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>


Regards,
Kamalesh.
