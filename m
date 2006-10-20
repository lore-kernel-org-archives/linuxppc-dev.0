Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6033C67B8F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 12:35:46 +1000 (EST)
Date: Thu, 19 Oct 2006 21:35:10 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc: support nested cpu features
Message-ID: <20061019213510.56617fff@pb15>
In-Reply-To: <1161308836.10524.109.camel@localhost.localdomain>
References: <1161308836.10524.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Oct 2006 11:47:16 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This patch adds some macros that can be used with an explicit label in
> order to nest cpu features. This should be used very careful but is
> necessary for the upcoming cell TB fixup.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Olof Johansson <olof@lixom.net>
