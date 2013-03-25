Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 29FE52C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 09:55:19 +1100 (EST)
Date: Mon, 25 Mar 2013 23:55:14 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Maxwell MacLean <mmaclean@symbotic.com>
Subject: Re: repository location (MPC5200b)
Message-ID: <20130325235514.1efcaed2@crub>
In-Reply-To: <97D2107B9206854998F088796329C879198B644F@AUSP01DAG0203>
References: <97D2107B9206854998F088796329C879198B644F@AUSP01DAG0203>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Mon, 25 Mar 2013 20:27:17 +0000
Maxwell MacLean <mmaclean@symbotic.com> wrote:

> Hello all,
> I have been following this list for a while now and am interested
> in getting a version of the latest work in progress Linux kernel
> with fixes for powerpc.

For latest work in progress kernel look at master branch in linux-next
tree

 http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git

> Yes, I am a kernel newbie, but I am learning! I have an inherited
> project based on version 2.6.28 that is compiled for an MPC5200b
> and there are some issues I am interested in fixing (or seeing If
> they are already fixed) .
> 
> I know there are many branches of development, but where can I get
> the 'best' kernel for my processor?

The current mainline kernel supports MPC5200b pretty well, you can
use latest stable release, branch "linux-3.8.y" of the stable tree

 http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git


HTH,

Anatolij

--
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0  Fax: +49-8142-66989-80 Email: office@denx.de
