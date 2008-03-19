Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18400.41990.995316.729968@cargo.ozlabs.ibm.com>
Date: Wed, 19 Mar 2008 16:26:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: crash in init_ipic_sysfs on efika
In-Reply-To: <20080317195305.GA13298@aepfle.de>
References: <20080317195305.GA13298@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> I cant reproduce this bug on my board, but:
> 
> The global primary_ipic in arch/powerpc/sysdev/ipic.c can remain NULL if
> ipic_init() fails. init_ipic_sysfs() will crash in that case.
> 
> Something like this may fix it:

Is this needed for 2.6.25?  Is the system at all usable if ipic_init
fails?

Paul.
