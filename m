Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 7E5882C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 05:42:11 +1100 (EST)
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by muin.pair.com (Postfix) with ESMTPSA id 1C30C8FC2C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 14:42:08 -0400 (EDT)
Received: by mail-la0-f47.google.com with SMTP id fj20so5707625lab.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 11:42:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363857961-23296-1-git-send-email-B32736@freescale.com>
References: <1363857961-23296-1-git-send-email-B32736@freescale.com>
Date: Thu, 21 Mar 2013 13:42:06 -0500
Message-ID: <CAOZdJXVs9My50m9KHzdbn6pjvhvLqHrqqMsK02z2kCFx8YB03w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/dts: Add qe support for 36bit
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

On Thu, Mar 21, 2013 at 4:26 AM, Zhicheng Fan <B32736@freescale.com> wrote:
> +       qe: qe@fffe80000 {
> +               ranges = <0x0 0xf 0xffe80000 0x40000>;

Are you sure this works?  The QE can't handle 36-bit addresses, and I
think the MURAM is located inside the QE address space.
