Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSxc043tzDsRr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:32:19 +1000 (AEST)
Message-ID: <1467027880.20278.74.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/boot: Add OPAL console to epapr wrappers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: oliver <oohall@gmail.com>, Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 27 Jun 2016 21:44:40 +1000
In-Reply-To: <CAOSf1CHP-PFf2nthzuPkUGZ5hcrSr2idGHDSc5XfZct7F4f7Jw@mail.gmail.com>
References: <1466754085-8230-1-git-send-email-oohall@gmail.com>
 <1466772481-11424-1-git-send-email-oohall@gmail.com>
 <87shvzcklm.fsf@linux.vnet.ibm.com>
 <CAOSf1CHP-PFf2nthzuPkUGZ5hcrSr2idGHDSc5XfZct7F4f7Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-27 at 16:51 +1000, oliver wrote:
> None of this is useful to us since we get most of this information
> from skiboot, but I'm not sure that's true for other platforms. The
> kernel boot log is fairly noisy as-is so we don't gain much from
> trimming. At the very least the other messages provide sanity checks
> that we've exited firmware and/or the bootloader without issues. I'll
> look at changing the returned error messages though, "invalid block
> type" is a pretty error useless you already know what you're looking
> for.

Right also if you crash in the kernel itself and these are your last
messages, knowing where the kernel was expanded can be useful.

Cheers,
Ben.
