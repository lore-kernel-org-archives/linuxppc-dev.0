Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18455.36914.506429.279177@cargo.ozlabs.ibm.com>
Date: Wed, 30 Apr 2008 07:16:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] Add fast little-endian switch system call
In-Reply-To: <20080429184047.47CB7247B4@gemini.denx.de>
References: <18454.35824.527711.355488@cargo.ozlabs.ibm.com>
	<20080429184047.47CB7247B4@gemini.denx.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Christoph Hellwig <hch@lst.de>, mtk.manpages@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk writes:

> This probably depends a bit on  the  performance  of  the  system  in
> question. Did you measure it - for example - on a 50 MHz MPC850 ?

The patch only affects arch/powerpc/kernel/entry_64.S.  So no, I
didn't measure it on a 50MHz MPC850, or indeed any 32-bit system. :)

Paul.
