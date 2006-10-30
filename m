Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 4746667C7C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 04:44:53 +1100 (EST)
Date: 30 Oct 2006 17:37:30 -0000
Message-ID: <20061030173730.6121.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
In-Reply-To: <200610292310.k9TNAHXZ013852@post.webmailer.de>
Cc: 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In article <200610292310.k9TNAHXZ013852@post.webmailer.de> Nicolas wrote:
> This patch add MPC52xx Interrupt controller for ARCH=powerpc.
> 
> It includes the main code in arch/powerpc/sysdev/ ad well as an header
> file in include/asm-powerpc.
> 
> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>

NAK.

Two requests:
  1.  Please include patches inline so that they may be easily reviewed.
  2.  Please do not remove copyright lines from files you modify.

-Dale
