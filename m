Return-Path: <timur.tabi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CC343B709F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 16:07:56 +1000 (EST)
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171]) by ozlabs.org (Postfix) with ESMTP id 23647DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 16:07:55 +1000 (EST)
Received: by qyk1 with SMTP id 1so883013qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2009 23:07:54 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1244603678.2431.18.camel@pasglop>
References: <1244603678.2431.18.camel@pasglop>
Date: Wed, 10 Jun 2009 01:07:54 -0500
Message-ID: <ed82fe3e0906092307oc381f94i276a647c48e9a0bc@mail.gmail.com>
Subject: Re: "next" branch update
From: Timur Tabi <timur@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 9, 2009 at 10:14 PM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> Hi !
>
> I've updated my "next" branch with the following patches. We're getting
> real close to the merge window now, so if something is missing, please
> holler ASAP.

[PATCH 1/2 v9] powerpc: introduce macro spin_event_timeout()

-- 
Timur Tabi
Linux kernel developer at Freescale
