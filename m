Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 693CB2C00F5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2013 01:15:16 +1100 (EST)
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by muin.pair.com (Postfix) with ESMTPSA id 13F658FC31
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 10:15:13 -0400 (EDT)
Received: by mail-la0-f54.google.com with SMTP id gw10so7230201lab.41
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 07:15:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363934612-29057-1-git-send-email-B32736@freescale.com>
References: <1363934612-29057-1-git-send-email-B32736@freescale.com>
Date: Fri, 22 Mar 2013 09:15:12 -0500
Message-ID: <CAOZdJXWUTdb_0-irrRCQY+i992EJYxkuRJ-WQoQ-VoU+ovrBrQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/dts: Fix the dts for p1025rdb 36bit
From: Timur Tabi <timur@tabi.org>
To: Zhicheng Fan <B32736@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 22, 2013 at 1:43 AM, Zhicheng Fan <B32736@freescale.com> wrote:
> +       qe: qe@fffe80000 {

> +               ranges = <0x0 0xf 0xffe80000 0x40000>;
> +               reg = <0xf 0xffe80000 0 0x480>;
> +               brg-frequency = <0>;
> +               bus-frequency = <0>;

These four lines should be unnecessary.

> +               status = "disabled"; /* no firmware loaded */
> +       };
