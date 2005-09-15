Return-Path: <kumar.gala@freescale.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A65F74DF-B782-4D9A-9D42-B80F13A82764@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 15 Sep 2005 10:12:02 -0500
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: non-inlined versions of local_irq*
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anyone know why on ppc32 we have non-inlined versions of:

extern void local_irq_enable(void);
extern void local_irq_disable(void);
extern void local_irq_restore(unsigned long);
extern void local_save_flags_ptr(unsigned long *);

 From looking at the code they are never used.  Just wondering if  
this was for debug or some other reason.

- kumar
