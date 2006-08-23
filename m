Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17643.60111.162041.406187@cargo.ozlabs.ibm.com>
Date: Wed, 23 Aug 2006 15:42:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] update pmac32_defconfig
In-Reply-To: <20060821124323.GA28970@aepfle.de>
References: <20060821124323.GA28970@aepfle.de>
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

> enable windfarm, pppoe, pegasus, Euro nls and magic sysrq.

Why windfarm?  It doesn't do anything useful on 32-bit machines, not
yet anyway...

Paul.
