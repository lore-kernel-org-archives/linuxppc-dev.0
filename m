Return-Path: <kallepokki@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id 33C8B67BC4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 07:23:51 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id v1so393798nzb
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 12:23:50 -0800 (PST)
Message-ID: <a425f86c0611161223q2fca81c5k692f02f62b0e96e9@mail.gmail.com>
Date: Thu, 16 Nov 2006 22:23:49 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Boris Shteinbock" <boris@fabiotec.com>
Subject: Re: Linux kernel 2.6 on Embedded Planet 8248 board
In-Reply-To: <455C974A.1000106@fabiotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <455C974A.1000106@fabiotec.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/16/06, Boris Shteinbock <boris@fabiotec.com> wrote:
> Hi. I am trying to bring up Linux kernel 2.6.16 on EP8248 board
> and I am having some serious problems with console driver there, which
> doesn't work (console on SMC).
> The kernel hangs after console_init() and BDM shows exception that I was
> unable to trace to any specific point.

When I tried using Linux on that board, I was stuck for a long time
because I had pipeline depth zero in the PlanetCore settings. My
system also hung while initializing the console driver. You might want
to double check you have pipeline depth one.
