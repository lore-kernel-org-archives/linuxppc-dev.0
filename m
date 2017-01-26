Return-Path: <rric.net@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8RcX00qmzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 03:06:35 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id r126so51355081wmr.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 08:06:35 -0800 (PST)
Sender: Robert Richter <rric.net@gmail.com>
Date: Thu, 26 Jan 2017 17:06:25 +0100
From: Robert Richter <rric@kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, oprofile-list@lists.sf.net,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: gcc trunk fails to build kernel on PowerPC64 due to oprofile
 warnings
Message-ID: <20170126160512.GE4906@rric.localdomain>
References: <20170126100044.7e439f72@kryten>
 <fe2c2fd9-d255-61ca-5328-ca5d45827f47@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe2c2fd9-d255-61ca-5328-ca5d45827f47@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26.01.17 10:46:43, William Cohen wrote:
> From 7e46dbd7dc5bc941926a4a63c28ccebf46493e8d Mon Sep 17 00:00:00 2001
> From: William Cohen <wcohen@redhat.com>
> Date: Thu, 26 Jan 2017 10:33:59 -0500
> Subject: [PATCH] Avoid hypthetical string truncation in oprofile stats buffer
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Increased the size of an internal oprofile driver buffer ensuring that
> the string was never truncated for any possible int value to avoid the
> following gcc-7 compiler error on ppc when building the kernel:

Please test gcc7 for other archs first. I don't think this is the only
change needed to avoid this warning in oprofile code.

Thanks,

-Robert
