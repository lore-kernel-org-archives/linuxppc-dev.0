Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18403.4476.851091.677190@cargo.ozlabs.ibm.com>
Date: Fri, 21 Mar 2008 12:38:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: crash in init_ipic_sysfs on efika
In-Reply-To: <63858171-157B-4726-94F2-E64B85A0D8D5@kernel.crashing.org>
References: <20080317195305.GA13298@aepfle.de>
	<63858171-157B-4726-94F2-E64B85A0D8D5@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> We should look and see if we can change init_ipic_sysfs() from a  
> subsys_initcall() to just getting called at the end of ipic_init().

If init_ipic is called from init_IRQ then I would expect that's way
too early to be calling sysfs stuff.

Paul.
