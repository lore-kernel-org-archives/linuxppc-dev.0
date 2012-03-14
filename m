Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6804B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 16:09:57 +1100 (EST)
Message-ID: <4F602822.1090503@windriver.com>
Date: Wed, 14 Mar 2012 13:09:54 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: hellohello <hellohello008@163.com>
Subject: Re: How to make a memory region to be cache disabled ? Cpu is mpc82XX
 or mpc83XX.
References: <EF9AEBBC0B9942B48CE5D29FF5CE814B@sfdomain.com>
In-Reply-To: <EF9AEBBC0B9942B48CE5D29FF5CE814B@sfdomain.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hellohello wrote:
> How to make a memory region  to be cache disabled in linux?
> I'm porting mpc83XX from vxworks to linux. Now meet a question: Cpu use a memory region (GPCM mode of bus)  to access peripherals, we need this memory to be cache disabled.
> Linux Kernel is 2.6.25.
> Thanks very much for any hint! 

ioremap() is fine enough since it always set I|G as TLB entry attribute.

Tiejun
