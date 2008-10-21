Return-Path: <mail4mz@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id 9B4FFDDDD8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 15:23:29 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so2344550fke.9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 21:23:28 -0700 (PDT)
Message-ID: <5c9cd53b0810202123x32488ba7vb3c70daa8d09aef@mail.gmail.com>
Date: Mon, 20 Oct 2008 21:23:28 -0700
From: "mike zheng" <mail4mz@gmail.com>
To: "Kim Phillips" <kim.phillips@freescale.com>
Subject: Re: Kernel Oops when run ifconfig on MPC8360MDS board
In-Reply-To: <20081020195009.6bf54d5a.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5c9cd53b0810201500j1c86dfffxdbfc6f5c5ab9728c@mail.gmail.com>
	<20081020195009.6bf54d5a.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/20/08, Kim Phillips <kim.phillips@freescale.com> wrote:
> On Mon, 20 Oct 2008 15:00:33 -0700
> "mike zheng" <mail4mz@gmail.com> wrote:
>
> > I have following kernel Oops when I run ifconfig to setup the UEC0 of
> > MPC8360MDS board. There is no hardware problem, the UEC0 runs well
> > under Uboot.
>
> does this occur on vanilla u-boot and kernel versions?  if so, which
> ones, and on what board revision?
>
The kernel Oops happened under Linux when I try to use "ifconfig" to
setup the eth0. Under Uboot, the UEC0 works fine. I am able to do
ping, tftp via the ethernet port.


> > Call backtrace:
> > C0126890 C00D59D0 C00D761C C012F400 C0130DD4 C01746B4 C017712C
> > C0127770 C004D8B0 C0005ABC 00000000 10001214 100023C4 0FEC4E00
> > 00000000
>
> might want to turn on verbose debugging while you're at it.

Which flag shall I turned on? I am not formaliar to the network driver. Thanks!
>
> Kim
>
