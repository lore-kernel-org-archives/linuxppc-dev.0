Return-Path: <jwboyer@gmail.com>
Received: from mail-iw0-f175.google.com (mail-iw0-f175.google.com
	[209.85.223.175]) by ozlabs.org (Postfix) with ESMTP id 79875B7D5C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 22:16:51 +1000 (EST)
Received: by iwn5 with SMTP id 5so1384506iwn.9
	for <linuxppc-dev@ozlabs.org>; Fri, 07 May 2010 05:16:49 -0700 (PDT)
Date: Fri, 7 May 2010 08:16:38 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: [PATCH 3/3] powerpc/kexec: Add support for FSL-BookE
Message-ID: <20100507121638.GQ2671@hansolo.jdub.homelinux.org>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
	<1270412343-19334-4-git-send-email-sebastian@breakpoint.cc>
	<42CE8E3E-E536-402C-970B-C4BBC036BEB9@kernel.crashing.org>
	<20100507072451.GA28507@Chamillionaire.breakpoint.cc>
	<y2me997b7421005070435ma23a4153m48545d4dd88db7c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <y2me997b7421005070435ma23a4153m48545d4dd88db7c9@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 07, 2010 at 07:35:34PM +0800, wilbur.chan wrote:
>Most booke powerpc are based on SMP, I am looking forward someone to
>implement this. hiahia

Erm, actually most Book-E powerpc CPUs are not SMP.  SMP Book-E cores are only
a fairly recent development, and if I recall correctly you need an e500mc core
to really have it work properly.

josh
