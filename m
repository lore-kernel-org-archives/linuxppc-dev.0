Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2F619DDEE8
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 01:54:08 +1000 (EST)
Date: Thu, 6 Sep 2007 10:53:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Esben Haabendal <eha@doredevelopment.dk>
Subject: Re: Configuring for UPM on MPC82xx using new device binding from Scott
Message-ID: <20070906155342.GA17184@ld0162-tx32.am.freescale.net>
References: <b0c1bc04d7f1f36bd546cd46ea1e035a@127.0.0.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0c1bc04d7f1f36bd546cd46ea1e035a@127.0.0.1>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 04:23:49PM +0200, Esben Haabendal wrote:
> Is it possible to configure chipselect to use UPM A and UPM B in an
> MPC8270 chip using the new CPM device bindings patches from Scott?
> 
> I need to pass in the 3 bits for MS (machine select to the relevant MRx
> register).

The BRx setup should be done by the firmware if at all possible.
As long as the entry is valid, cuboot-pq2.c shouldn't change the
attributes.

-Scott
