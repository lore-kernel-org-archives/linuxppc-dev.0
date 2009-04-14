Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 12010DDFB1
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 21:39:51 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1465894ywe.39
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 04:39:49 -0700 (PDT)
Date: Tue, 14 Apr 2009 07:39:27 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: =?utf-8?B?77+977+977+977+9IO+/ve+/vQ==?= <sjy1937@hotmail.com>
Subject: Re: Has anyone debugged kernel 2.6.27 using KGDB?
Message-ID: <20090414113927.GA2427@yoda.jdub.homelinux.org>
References: <BAY112-W200D1650425A8B738616C9A37C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <BAY112-W200D1650425A8B738616C9A37C0@phx.gbl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 14, 2009 at 07:51:18AM +0000, ���� �� wrote:
>
>Hi all.
>
>Has anyone tried to debug kernel 2.6.27 using KGDB?
>
>I'm now trying to use KGDB but I can't use it at all.
>
>I already red documents in kernel source about KGDB and I also know that KGDB is merged since 2.6.26.
>
>Absoultely I'm already done what I have to do in menuconfig like
>
> 
>
>enable KGDB option
>
>enable tty serial
>
>enabel compile with .. and so on..
>
> 
>
>I have embedded board that is target (PXA270, v2.6.27 android kernel) and development PC that is host(2.6.23)

That is an ARM based board.  This is the PowerPC list.  Perhaps you should find
a kgdb or ARM specific mailing list.

josh
