Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17448.26428.269343.872893@cargo.ozlabs.ibm.com>
Date: Tue, 28 Mar 2006 09:29:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Unify the 32 and 64 bit idle loops
In-Reply-To: <0ED6B216-1F6E-40E7-9EB8-399F4066E273@kernel.crashing.org>
References: <17443.49609.63829.380622@cargo.ozlabs.ibm.com>
	<0ED6B216-1F6E-40E7-9EB8-399F4066E273@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> I'm now seeing the following kernel panic on an 83xx system (603  
> core) w/preempt on (2.6.16 is ok on this system):

My mistake.  I just pushed a fix.

Paul.
