Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 92DA967FCC
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 13:14:02 +1000 (EST)
Date: Thu, 26 Oct 2006 20:13:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc3 1/2] ehea: kzalloc GFP_ATOMIC fix
Message-Id: <20061026201313.9c831fc9.akpm@osdl.org>
In-Reply-To: <200610251311.43009.ossthema@de.ibm.com>
References: <200610251311.43009.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Oct 2006 13:11:42 +0200
Jan-Bernd Themann <ossthema@de.ibm.com> wrote:

> This patch fixes kzalloc parameters (GFP_ATOMIC instead of GFP_KERNEL)

why?
