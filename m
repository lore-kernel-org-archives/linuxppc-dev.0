Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 487C32BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Dec 2004 20:52:17 +1100 (EST)
Date: Mon, 13 Dec 2004 01:52:13 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Message-ID: <20041213095213.GB917@gate.ebshome.net>
References: <20041213091027.GA2384@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041213091027.GA2384@schottelius.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [BUG?] [PPC/403/IBM] compile error 2.6.9 and earlier
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Dec 13, 2004 at 10:10:28AM +0100, Nico Schottelius wrote:
> I didn't find linux-ppc list on vger, so I hope this list is correct:

Look at http://ozlabs.org/mailman/listinfo. I'm forwarding my reply to 
linuxppc-embedded as well.

> When trying to compile a kernel for my ibm thinclient, which has a
> 403 PPC processor, I get the attached compile error. 

Yes, it's a known problem, 403 build is broken and 4xx maintainer told 
me that it hadn't been removed completely mostly because of 
sentimental reasons (IIRC first TiVos used 403 chip);

Looks like we have a person who needs it working. Feel free to fix it 
and submit a patch :).

--
Eugene
