Return-Path: <amodra@gmail.com>
Received: from mail-pb0-x230.google.com (mail-pb0-x230.google.com
 [IPv6:2607:f8b0:400e:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E8432C00FD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 11:19:09 +1000 (EST)
Received: by mail-pb0-f48.google.com with SMTP id md4so2608479pbc.21
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 18:19:07 -0700 (PDT)
Date: Sat, 27 Jul 2013 10:49:01 +0930
From: Alan Modra <amodra@gmail.com>
To: Ryan Arnold <ryanarn@us.ibm.com>
Subject: Re: SIGSTKSZ/MINSIGSTKSZ too small on 64bit
Message-ID: <20130727011901.GG3294@bubble.grove.modra.org>
References: <20130726122325.10b900e4@kryten>
 <20130726050528.GF3294@bubble.grove.modra.org>
 <OFE7C3B8EC.F822633B-ON86257BB4.00708A32-86257BB4.00763ECE@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFE7C3B8EC.F822633B-ON86257BB4.00708A32-86257BB4.00763ECE@us.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 rsa@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 26, 2013 at 04:31:34PM -0500, Ryan Arnold wrote:
> Adhemerval and I were just looking at the signal stack frames and I'd
> noticed the increase in size due to the addition of the HTM bits so this is
> great timing.
> 
> I tried a sigstack.h patch that increased the values as you indicated and
> it cleaned up the failing tst-cancel21* testcases on POWER8.  I didn't try
> it on POWER7 yet.

I've tested on power7 using a copy of
sysdeps/unix/sysv/linux/sparc/bits/sigstack.h
as
sysdeps/unix/sysv/linux/powerpc/bits/sigstack.h

-- 
Alan Modra
Australia Development Lab, IBM
