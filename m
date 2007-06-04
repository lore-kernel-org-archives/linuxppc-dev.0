Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/21] This is my pending series for 2.6.23
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1180940405.31677.45.camel@localhost.localdomain>
References: <1180934134.603289.870346178920.qpush@grosgo>
	<1180940405.31677.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 17:21:06 +1000
Message-Id: <1180941666.31677.47.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 17:00 +1000, Benjamin Herrenschmidt wrote:

> And one of the signal changes is causing init to segv on my laptop,
> which I'm quite happy to blame on my signal frame allocation change.
> (Well, at least with the serie applied up to Christoph 3rd patch, it
> still boots). I'll debug that and post an updated patch.

Fixed... posting a replacement to patch 19/21 as a reply to the initial
patch email.

Ben.
