Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6CADC67D91
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 19:41:37 +1000 (EST)
Date: Thu, 28 Jul 2005 10:41:27 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: bbosch@iphase.com
Message-Id: <20050728104127.4dfce3ec.ajz@cambridgebroadband.com>
In-Reply-To: <17127.49093.492554.638213@waldo.lisle.iphase.com>
References: <17127.49093.492554.638213@waldo.lisle.iphase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM MCC sample driver?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 27 Jul 2005 12:09:25 -0500
bbosch@iphase.com wrote:

> A couple of years ago, Adam Kaczynski announced a sample MCC HDLC and
> Transparent mode driver.  Both the URL Adam posted and Adam's email
> address are no longer valid.  Is this code or any other Linux MCC
> driver available anywhere?  I need to develop an MCC driver for a
> project I am working on and it would be very helpful to have an
> example to start with.
> 

I'm not sure what you mean by MCC.  I've got an PQI SCC tranparent mode driver which implements a
character device for reading from/writing to a PCM bus.  I wrote it a couple of years ago and tested
it using an external loopback - but I've never used it in anger.  Would this be useful to you?

Alex
