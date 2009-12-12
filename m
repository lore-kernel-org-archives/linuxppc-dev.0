Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 102B7B6EF5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 15:25:01 +1100 (EST)
Subject: Re: [RFC PATCH v2 3/4] powerpc: allow ioremap within reserved
	memory regions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B22E4CB.2040509@yahoo.es>
References: <1260297833-17625-1-git-send-email-albert_herranz@yahoo.es>
	<1260297833-17625-4-git-send-email-albert_herranz@yahoo.es>
	<1260569600.16132.375.camel@pasglop>  <4B22E4CB.2040509@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 15:24:56 +1100
Message-ID: <1260591896.16332.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-12-12 at 01:33 +0100, Albert Herranz wrote:
> 
> I'll look into this.
> I used a single lmb range just as the current code does to avoid any
> unwanted side effects as I didn't audit all the mm code.

Well, I -may- be missing something ... but I think outside of the setup
of the initial mapping, we should be fine. Well, you'll tell me if I'm
wrong here :-)

Cheers,
Ben.
