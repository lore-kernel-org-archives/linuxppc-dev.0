Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17A7667A0E
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 05:33:05 +1100 (EST)
Date: Wed, 29 Mar 2006 20:32:59 +0200
From: Olaf Hering <olh@suse.de>
To: Greg Smith <gsmith@nc.rr.com>
Subject: Re: [OT] ppc64 serialization problem
Message-ID: <20060329183259.GA18514@suse.de>
References: <1143597506.3075.53.camel@localhost.localdomain>
	<17450.2061.510951.479016@cargo.ozlabs.ibm.com>
	<1143656433.3075.108.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1143656433.3075.108.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Mar 29, Greg Smith wrote:

> So it is clear between .A and .B -> value of b was read then written. If
> anything happens between .A and .B to ->b, then it is lost.

Even gcc4.1 does it that way with -O0.
