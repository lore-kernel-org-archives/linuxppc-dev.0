Return-Path: <vapier.adi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 18ADAB7294
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 10:17:19 +1000 (EST)
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id 65C86DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 10:17:16 +1000 (EST)
Received: by gxk6 with SMTP id 6so2125122gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 17:17:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Thu, 18 Jun 2009 19:55:58 -0400
Message-ID: <8bd0f97a0906181655jd68835fg10fe0783b6a6068d@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 13, 2009 at 03:10, Paul Mackerras wrote:
> +typedef struct {
> + =C2=A0 =C2=A0 =C2=A0 long long counter;
> +} atomic64_t;

lack of volatile seems odd compared to:
include/linux/types.h:
typedef struct {
    volatile int counter;
} atomic_t;
-mike
