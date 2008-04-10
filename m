Return-Path: <hch@lst.de>
Date: Thu, 10 Apr 2008 12:56:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: Re: [PATCH 5/6] [POWERPC] properly declare onstack completion in
	iseries veth
Message-ID: <20080410105636.GA10048@lst.de>
References: <20080409072230.C861EDDED0@ozlabs.org>
	<20080409083616.GA24712@lst.de> <1207775002.9079.25.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1207775002.9079.25.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2008 at 07:03:22AM +1000, Benjamin Herrenschmidt wrote:
> I don't think there's any difference between the _ONSTACK variant
> and the normal one without lockdep, is there ?

No there's not.  Thus it's a guaranteed no-op and can easily go in.
