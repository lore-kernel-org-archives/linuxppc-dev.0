Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
 [209.85.214.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 94BB9B6F67
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 11:41:59 +1100 (EST)
Received: by bkcjm19 with SMTP id jm19so1332776bkc.15
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Dec 2011 16:41:54 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1322510541-30688-1-git-send-email-galak@kernel.crashing.org>
References: <1322510541-30688-1-git-send-email-galak@kernel.crashing.org>
Date: Thu, 1 Dec 2011 19:41:54 -0500
Message-ID: <CAP=VYLr406SnYQr5uf3aFwdteyCESxQpW=HBZQHNffh3s=YKvw@mail.gmail.com>
Subject: Re: [RFC][PATCH] update FSL 16550 nodes to have...
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2011 at 3:02 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Need to fixup the commit message

I had this written when I was thinking of re-sending the dts
with the other three, that is before I realized the dts patch
would then overwhelm the other patches completely.  :)

P.

----------------
    ppc: update FSL 16550 nodes to have fsl,ns16550 compat entry

    There is an errata relating to break handling on some of
    the Freescale 16550 implementations.  By marking the nodes
    with a fsl prefix, we can use that to know when to enable
    the errata handling.
----------------
