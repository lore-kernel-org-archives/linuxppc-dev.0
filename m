Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0FhK4GXgzDqWR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 19:11:29 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id y143so7353209pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 00:11:29 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 13 Jan 2017 13:41:22 +0530
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Use octal numbers for file permissions
Message-ID: <20170113081122.GA14043@localhost.localdomain>
References: <20170112035413.26544-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170112035413.26544-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2017 at 02:54:13PM +1100, Russell Currey wrote:
> Symbolic macros are unintuitive and hard to read, whereas octal constants
> are much easier to interpret.  Replace macros for the basic permission
> flags (user/group/other read/write/execute) with numeric constants
> instead, across the whole powerpc tree.
>

I know Linus said otherwise, but I wonder if the churn is worth it.
At user mode (do man 2 chmod), these constants are used frequently,
even with chmod the command we use chmod a+r equivalents or chmod
u+r. My big concern with numbers is how do you know you did not
turn on the sticky bit for a file? Can you imagine if someone used
0x644 or 0x444 would we catch it?

Not resisting, but thinking if the churn and what follows might be
OK.

Balbir Singh.
