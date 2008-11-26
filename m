Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix system calls on Cell entered with XER.SO=1
Date: Wed, 26 Nov 2008 11:52:43 +0100
References: <18732.40814.991329.362635@cargo.ozlabs.ibm.com>
In-Reply-To: <18732.40814.991329.362635@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200811261152.44152.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 November 2008, Paul Mackerras wrote:
> This fixes it by moving the clearing of CR0.SO to after the
> ACCOUNT_CPU_USER_ENTRY call in the system call entry path.

Thanks for taking care of this!

> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
