Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 878DD2C0095
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Jun 2013 04:54:06 +1000 (EST)
Date: Thu, 06 Jun 2013 11:53:52 -0700 (PDT)
Message-Id: <20130606.115352.641926194470746732.davem@redhat.com>
To: eric.dumazet@gmail.com
Subject: Re: [PATCH] net: Unbreak compat_sys_{send,recv}msg
From: David Miller <davem@redhat.com>
In-Reply-To: <1370526337.24311.335.camel@edumazet-glaptop>
References: <e3bf421e44c6d27817c15a8683612a49e093b419.1370496702.git.luto@amacapital.net>
 <20130606.002625.223430401087826901.davem@davemloft.net>
 <1370526337.24311.335.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mikey@neuling.org, netdev@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net, linuxppc-dev@ozlabs.org,
 trinity@vger.kernel.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 06 Jun 2013 06:45:37 -0700

> On Thu, 2013-06-06 at 00:26 -0700, David Miller wrote:
>> From: Andy Lutomirski <luto@amacapital.net>
>> Date: Wed,  5 Jun 2013 22:38:26 -0700
>> 
>> > I broke them in this commit:
>> > 
>> >     commit 1be374a0518a288147c6a7398792583200a67261
>> >     Author: Andy Lutomirski <luto@amacapital.net>
>> >     Date:   Wed May 22 14:07:44 2013 -0700
>> > 
>> >         net: Block MSG_CMSG_COMPAT in send(m)msg and recv(m)msg
>> > 
>> > This patch adds __sys_sendmsg and __sys_sendmsg as common helpers that accept
>> > MSG_CMSG_COMPAT and blocks MSG_CMSG_COMPAT at the syscall entrypoints.  It
>> > also reverts some unnecessary checks in sys_socketcall.
>> > 
>> > Apparently I was suffering from underscore blindness the first time around.
>> > 
>> > Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> 
>> Eric, can you test this patch too?
> 
> Yes, this fixes the problem as well on x86_64
> 
> Tested-by: Eric Dumazet <edumazet@google.com>

Applied, thanks.
