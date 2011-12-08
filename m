Return-Path: <diggskevin38@gmail.com>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C42C61007D7
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 06:53:26 +1100 (EST)
Received: by dadp13 with SMTP id p13so1934185dad.15
 for <linuxppc-dev@ozlabs.org>; Thu, 08 Dec 2011 11:53:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <m2fwgvnwlm.fsf@igel.home>
References: <m2fwgvnwlm.fsf@igel.home>
Date: Thu, 8 Dec 2011 13:53:24 -0600
Message-ID: <CAKTLLVTHHSDTxybfJn3r0JOeRGtxgzJyCwAFf8w8gDxqbuXbyA@mail.gmail.com>
Subject: Re: cpu idle time going backward
From: kevin diggs <diggskevin38@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/8/11, Andreas Schwab <schwab@linux-m68k.org> wrote:
> There seems to be something wrong with cpu idle time accounting at least
> on G5.  The value as reported in the cpu lines in /proc/stat seems to be
> stuck in the interval [100000,210000] for each cpu, jumping back at
> random points.  Any idea what could be the problem?
>
> Andreas.
>
> --
What kernel versions?

kevin
