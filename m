Return-Path: <B29882@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7CA24B6F7E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 16:24:12 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: radha krishna <ramamru@gmail.com>
Subject: Re: Kdump/kexec for mpc85xx
Date: Thu, 27 Oct 2011 05:21:01 +0000
Message-ID: <CAEsOVNexaLHCs_rjC9z1_NeSTYYYEzp_+u0F-JwwrR3dt387Ag@mail.gmail.com>
References: <CAJ4m0g6vDoT6wy3owmRpJowQrJqMyB0F80y=BBTcBZtzHJUd2A@mail.gmail.com>
In-Reply-To: <CAJ4m0g6vDoT6wy3owmRpJowQrJqMyB0F80y=BBTcBZtzHJUd2A@mail.gmail.com>
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

On Wed, Oct 26, 2011 at 11:57 PM, radha krishna <ramamru@gmail.com> wrote:
> Hi ,
>
> The subject is changed to "Kdump/kexec for mpc85xx", as i am going to use=
 it
> on P2010 and MPC8567 processors as will. So that it will not confuse othe=
rs
> and to continue as a separate topic. In fact, i have selected P2041 which=
 is
> e500mc core, for my next project.
> Please provide more details on "how to Kdump/kexec for 85xx?". I mean ope=
n
> source versions of kexec-tools, linux versions, etc....
> At preset, i have been using linux-2.6.32 on P2010 based board and ELDK42=
 as
> tool chain.

You will need a newer kernel, I'm not precise of the exact release.
But kexec-tools project contains a HOWTO in the project under
'docs/mpc85xx.txt'. Please read that over and give it a shot. It
should work for the P2010 or the P2041 cores.

-M=
