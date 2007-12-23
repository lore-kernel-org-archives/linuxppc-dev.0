Return-Path: <jwboyer@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by ozlabs.org (Postfix) with ESMTP id C92FDDDE1A
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 07:05:28 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so910733mue.1
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 12:05:26 -0800 (PST)
Date: Sun, 23 Dec 2007 14:05:16 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH] Do not fail build if mkimage is not available
Message-ID: <20071223140516.4fed7dd0@vader.jdub.homelinux.org>
In-Reply-To: <200712232031.09133.mb@bu3sch.de>
References: <200712232031.09133.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 23 Dec 2007 20:31:08 +0100
Michael Buesch <mb@bu3sch.de> wrote:

> This fixes the boot image wrapper script to not fail the kernel
> build if mkimage is not available.
> As some distributions don't ship the mkimage program and I am not
> interested in uboot images anyway, I don't want to fail the whole kernel
> build process because of this unneeded dependency.
> 
> Simply drop an error message, but don't fail the build.

This is probably OK for now, but I'm working on getting mkimage merged
into the kernel so it will just get ripped back out later if I'm
successful.

josh
