Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17153.8284.3721.188488@cargo.ozlabs.ibm.com>
Date: Tue, 16 Aug 2005 09:08:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <3E78617E-D2D4-44DB-A3F1-9C5D8814E37F@freescale.com>
References: <3E78617E-D2D4-44DB-A3F1-9C5D8814E37F@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc64-dev@ozlabs.org
Subject: Re: CONFIG_FRAME_POINTER on ppc/ppc64?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Is there any reason we dont allow building with frame pointers on ppc/ 
> ppc64?

Because -fomit-frame-pointer and -fno-omit-frame-pointer have no
effect on ppc or ppc64, I assume. :)

Paul.
