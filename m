Return-Path: <pladow@gmail.com>
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com
 [IPv6:2a00:1450:4010:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B68182C04D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2013 03:15:03 +1000 (EST)
Received: by mail-la0-f54.google.com with SMTP id ec20so7475204lab.41
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 10:14:59 -0700 (PDT)
MIME-Version: 1.0
Sender: pladow@gmail.com
In-Reply-To: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
References: <CAN8Q1EdnN9+kKGy+voF3=EyPfbHv04Emfz=uA6XKMJEAkvLpAA@mail.gmail.com>
Date: Fri, 21 Jun 2013 10:14:58 -0700
Message-ID: <CAN8Q1Ed9Lpg1Sog5tQODe+jqCRXBBH3d_UeR5usdc23CD7vwjg@mail.gmail.com>
Subject: Re: Inbound PCI and Memory Corruption
From: Peter LaDow <petela@gocougs.wsu.edu>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 21, 2013 at 9:56 AM, Peter LaDow <petela@gocougs.wsu.edu> wrote:
> We are running into a case where we get memory corruption when an
> external PCI master writes to the processor.  We are using an MPC8349
> with an external Intel 82540EP (an E1000) part.  I've spent several
> weeks on the e1000 list trying to track down this problem, and after
> some digging I'm thinking the problem is somewhere other than the
> e1000 driver or the e1000 part.

After a (finally!) successful search of the list archive, I did find this:

http://web.archiveorange.com/archive/v/9IQA26gPvdf4foaTcmCV

Which seems very related to my problem.  However, the patch that is
ultimately referenced is in place in 3.0.80 (see
https://lists.ozlabs.org/pipermail/linuxppc-dev/2006-February/021267.html).

Hmmm...  perhaps our FDT is bad?

Thanks,
Pete
