Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18022.14166.83442.173369@cargo.ozlabs.ibm.com>
Date: Wed, 6 Jun 2007 14:25:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] Donate dedicated CPU cycles
In-Reply-To: <1180638885.5756.11.camel@goblue>
References: <1180638885.5756.11.camel@goblue>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jake Moilanen writes:

> A Power6 can give up CPU cycles on a dedicated CPU (as opposed to a
> shared CPU) to other shared processors if the administrator asks for it
> (via the HMC).
> 
> This patch enables that to work properly on P6.

Is this something that needs to be controlled from userland, e.g. by a
sysctl or something in /sys?

Paul.
