Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Make IOMMU code safe for > 132 GB of memory
Date: Tue, 22 Jan 2008 14:20:34 +1100
References: <259a1d6aca476af7c572bdfea564a8a17aca3244.1200898886.git.michael@ellerman.id.au>
In-Reply-To: <259a1d6aca476af7c572bdfea564a8a17aca3244.1200898886.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200801221420.35565.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Currently the IOMMU code allocates one page for the segment table,
> that isn't safe if we have more than 132 GB of RAM.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Can I have a Cell machine with > 132GB of RAM? :D


Jeremy
