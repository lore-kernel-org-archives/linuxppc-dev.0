Return-Path: <amodra@gmail.com>
Received: from mail-pb0-x22a.google.com (mail-pb0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE6DD14008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 20:36:11 +1100 (EST)
Received: by mail-pb0-f42.google.com with SMTP id rr13so1701643pbb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 02:36:08 -0700 (PDT)
Date: Wed, 26 Mar 2014 20:06:02 +1030
From: Alan Modra <amodra@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 10/33] powerpc: Ignore TOC relocations
Message-ID: <20140326093602.GM18201@bubble.grove.modra.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
 <1395747879-5948-11-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395747879-5948-11-git-send-email-anton@samba.org>
Cc: mikey@neuling.org, rusty@rustcorp.com.au, ulrich.weigand@de.ibm.com,
 mjw@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2014 at 10:44:16PM +1100, Anton Blanchard wrote:
> The linker fixes up TOC. relocations, so prom_init_check.sh should
> ignore them.

Err, .TOC. you mean.  Presumably something strips off the leading dot
somewhere?

> -btext_setup_display"
> +btext_setup_display TOC."

-- 
Alan Modra
Australia Development Lab, IBM
