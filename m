Return-Path: <timur.tabi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0E2F7B711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 00:54:24 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 3AEA6DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 00:54:22 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1834925qwe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 07:54:21 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1245052241.7705.78.camel@concordia>
References: <adf502e7c85161d77fdcaca24f55ba6b418c7f04.1244616523.git.michael@ellerman.id.au>
	<1245052241.7705.78.camel@concordia>
Date: Mon, 15 Jun 2009 09:54:21 -0500
Message-ID: <ed82fe3e0906150754w125c6283q2468213b59c7f114@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
From: Timur Tabi <timur@freescale.com>
To: michael@ellerman.id.au
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

On Mon, Jun 15, 2009 at 2:50 AM, Michael Ellerman<michael@ellerman.id.au> wrote:
> arch/powerpc/platforms/chrp/setup.c:378: error: the frame size of 1040 bytes is larger than 1024 bytes

What's so bad about a frame size larger than 1024?


-- 
Timur Tabi
Linux kernel developer at Freescale
