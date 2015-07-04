Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 109321A067D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jul 2015 11:55:31 +1000 (AEST)
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5B2691401E7
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Jul 2015 11:55:29 +1000 (AEST)
Received: by pabvl15 with SMTP id vl15so64252341pab.1
 for <linuxppc-dev@ozlabs.org>; Fri, 03 Jul 2015 18:55:28 -0700 (PDT)
Subject: Re: [PATCH SLOF v4 0/4] GPT fixes and LVM support with FAT
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 thuth@redhat.com, segher@kernel.crashing.org
References: <1435836938-22889-1-git-send-email-nikunj@linux.vnet.ibm.com>
Cc: dvaleev@suse.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55973D09.1070406@ozlabs.ru>
Date: Sat, 4 Jul 2015 11:55:21 +1000
MIME-Version: 1.0
In-Reply-To: <1435836938-22889-1-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2015 09:35 PM, Nikunj A Dadhania wrote:
> Following patchset implements some improvements and cleanup for the
> GPT booting code:
>
> patch 1: Simplify the gpt detection code with lesser scopes and add
> 	 comments.
>
> patch 2: Introduce 8byte LE helpers: x@-le and x!-le
>
> patch 3: As we need to detect FAT partition, implement a helper that
> 	 can be used both from GPT code and "fat-bootblock?"
>
> patch 4: Implement GPT FAT for LVM suport and make GPT detection code
> 	 robust

Thanks, pushed to github.


>
> Changelog v3:
> * Dropped patch for renaming "block" variable
> * Fix bug in seek-pos updation code
>
> Changelog V2:
> * Optimize gpt detection code
> * Fixed stack comments
> * Rename verify-gpt-partition, as it was doing more than that. Added
>    comments.
>
> Nikunj A Dadhania (4):
>    disk-label: simplify gpt-prep-partition? routine
>    introduce 8-byte LE helpers
>    disk-label: introduce helper to check fat filesystem
>    disk-label: add support for booting from GPT FAT partition
>
>   slof/fs/little-endian.fs       |   6 ++
>   slof/fs/packages/disk-label.fs | 162 +++++++++++++++++++++++++++--------------
>   2 files changed, 112 insertions(+), 56 deletions(-)
>


-- 
Alexey
