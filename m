Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 731861A076B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2015 11:57:09 +1000 (AEST)
Date: Sun, 24 May 2015 11:57:04 +1000
From: Anton Blanchard <anton@samba.org>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@au1.ibm.com>, Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/configs: merge pseries_defconfig and
 pseries_le_defconfig
Message-ID: <20150524115704.4b8ea9aa@kryten>
In-Reply-To: <1431668830-22734-1-git-send-email-cyrilbur@gmail.com>
References: <1431668830-22734-1-git-send-email-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,

> These two configs should be identical with the exception of big or
> little endian
> 
> The big endian version has XMON_DEFAULT turned on while the little
> endian has XMON_DEFAULT not set. Enable XMON_DEFAULT for little
> endian.

I disabled it on the LE defconfig on purpose. In most cases we want to
get the kernel back around and running again. I got sick of building a
mainline kernel for a non development box and coming back to it stuck in
xmon.

Should we disable it by default and require developers who want xmon to
set the config option, or use the xmon=on boot?

Anton
