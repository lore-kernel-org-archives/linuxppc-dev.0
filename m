Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17561.56593.481580.556093@cargo.ozlabs.ibm.com>
Date: Thu, 22 Jun 2006 09:58:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH] Don't access HID registers if running on a Hypervisor.
In-Reply-To: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
References: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jimi Xenidis writes:

> The following patch avoids accessing Hypervisor privilege HID
> registers when running on a Hypervisor (MSR[HV]=0).

Why?  Aren't the writes defined to be no-ops when not in hypervisor
mode?

Paul.
