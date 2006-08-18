Return-Path: <mikey@ozlabs.org>
To: Anton Blanchard <anton@samba.org>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] PURR should use correct cpu feature bit 
In-reply-to: <20060818184821.GC27947@krispykreme> 
References: <20060818184821.GC27947@krispykreme>
Date: Fri, 18 Aug 2006 14:32:00 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060818193205.377E367B22@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Now we have a PURR cpu feature bit, we should use it in sysfs code.

Snap... Paulus has this in his tree for 2.6.19

http://git.kernel.org/git/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=afd05423e02bc7391a7489b686ba1e166b6e8349

Mikey
