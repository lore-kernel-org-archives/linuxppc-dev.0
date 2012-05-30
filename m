Return-Path: <ppc6dev@digitaldans.com>
Received: from digitaldans.com (digitaldans.com [69.36.177.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5786CB7032
 for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2012 18:16:03 +1000 (EST)
Message-Id: <6F7E3816-E71B-466A-9C6F-9928E1CFD7B1@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
Date: Wed, 30 May 2012 00:59:06 -0700
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org, Bob Cochran <ppc@mindchasers.com>,
 support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Joakim.

On May 30, 2012, at 12:43 AM, Joakim Tjernlund wrote:

> I have tested this briefly with BDI2000 on P2010(e500) and
> it works for me. I don't know if there are any bad side effects,  
> therfore
> this RFC.

We used to have MSR_DE surrounded by CONFIG_something
to ensure it wasn't set under normal operation.  IIRC, if MSR_DE
is set, you will have problems with software debuggers that
utilize the the debugging registers in the chip itself.  You only want
to force this to be set when using the BDI, not at other times.

Thanks.

	-- Dan
