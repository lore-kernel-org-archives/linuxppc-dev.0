Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id A5241DDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 17:58:11 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070417014331.85276DDEBC@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <076a5a3adc4b5b29a3fd2ade48d52184@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Initialise spinlock in the DEBUG_PAGEALLOC code
Date: Tue, 17 Apr 2007 02:57:55 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue Apr 17 11:43:12 EST 2007, Michael Ellerman wrote:
> -static spinlock_t linear_map_hash_lock;
> +static spinlock_t linear_map_hash_lock = SPIN_LOCK_UNLOCKED;

I think the people in this thread

[KJ][PATCH]SPIN_LOCK_UNLOCKED cleanup in arch/powerpc
http://ozlabs.org/pipermail/linuxppc-dev/2007-April/034210.html

SPIN_LOCK_UNLOCKED cleanup,use DEFINE_SPINLOCK or
__SPIN_LOCK_UNLOCKED where ever appropriate.

would like you to initialize it differently.  (I think it has
to do with the lock dependancy stuff).

milton
