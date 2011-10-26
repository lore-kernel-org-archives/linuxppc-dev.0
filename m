Return-Path: <B29882@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E56DD1007D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2011 11:57:57 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: radha krishna <ramamru@gmail.com>
Subject: Re: Kdump/kexec for mpc83xx
Date: Wed, 26 Oct 2011 00:57:48 +0000
Message-ID: <CAEsOVNf1+Twg7zr1BcOKu4D3dXEUe7Xjws0o9utNqoYBCj5RxA@mail.gmail.com>
References: <CAJ4m0g4TT3dNeRXqiU1oTa+tcjn+62jjrXJYTQjMoOaDAT48xg@mail.gmail.com>
In-Reply-To: <CAJ4m0g4TT3dNeRXqiU1oTa+tcjn+62jjrXJYTQjMoOaDAT48xg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 24, 2011 at 7:35 AM, radha krishna <ramamru@gmail.com> wrote:
> Hi Team,
>
> I am using Linux-3.0 on mpc8379 RDB. I have downloaded kexec-tools-2.0.2
> package from open source and cross compiled for ppc_6xx.
> But, the kexec is not booting with kernel loaded with "kexec -l".

I'm not sure who has tested on 83xx stuff, I've only done 85xx.

-M=
