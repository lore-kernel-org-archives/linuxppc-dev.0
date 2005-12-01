Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17295.30816.292109.714074@cargo.ozlabs.ibm.com>
Date: Fri, 2 Dec 2005 09:25:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051201204632.GA3764@suse.de>
References: <20051201204632.GA3764@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: hide CONFIG_ALTIVEC on iSeries
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> Do not offer CONFIG_ALTIVEC for legacy iSeries. They predate the 970.

I am still hoping that we will get to the point of being able to build
a single binary kernel for both iSeries and the rest (pSeries, pmac,
etc.).  If we put in this patch then we'll undoubtedly forget to take
it back out when we do get to the single binary kernel.

Does it cause any actual problem to have CONFIG_ALTIVEC offered on
legacy iSeries?

Paul.
