Return-Path: <dan.j.williams@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190])
	by ozlabs.org (Postfix) with ESMTP id BF9F8DDE3D
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 16:55:28 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w9so643317mue
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 22:55:26 -0700 (PDT)
Message-ID: <e9c3a7c20703152255q16563803q33a5893c210634d1@mail.gmail.com>
Date: Thu, 15 Mar 2007 22:55:26 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
In-Reply-To: <17914.10957.754781.940591@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<17914.10957.754781.940591@cargo.ozlabs.ibm.com>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/15/07, Paul Mackerras <paulus@samba.org> wrote:
> Wolfgang Denk writes:
>
> > This patch is based on and requires a set of patches posted to the
> > linux-raid mailing list by Dan Williams on 2007-01-23:
>
> Those patches don't seem to be upstream in Linus' tree.  Are they in
> -mm, or is anyone pushing for them to be?
>
They are in -mm (git-md-accel.patch).  I'll review this driver and and
integrate it into my next push to Andrew, along with some further
cleanups.

> Paul.

Dan
