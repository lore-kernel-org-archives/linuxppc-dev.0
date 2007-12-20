Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9EC1DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Dec 2007 05:42:03 +1100 (EST)
Date: Thu, 20 Dec 2007 21:41:39 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jonathan Journo <Jonathan@elspec-ltd.com>
Subject: Re: MPC885 - USB HCI drivers.
Message-ID: <20071220214139.18848604@kernel.crashing.org>
In-Reply-To: <8A79E59E6C48F2468E8A7C8CE1F4C7E801D636CC5F@mailsrv.Elspec.local>
References: <8A79E59E6C48F2468E8A7C8CE1F4C7E801D636CC5F@mailsrv.Elspec.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 20 Dec 2007 08:53:07 +0200
Jonathan Journo wrote:

> Hello Pantelis ,
> 
> I saw you used usb host driver on mpc8xx. I am trying to make one on
> MPC885 because vxworks drivers are not compatible with it.
> 
> To begin I tried to make the loopback mode (test) working but it
> doesn't work. Is there anything that is not mentioned on the
> datasheet in" USB host controller initialization example" that I have
> to know to make it work.

iirc, Panto was working with 8271, not 8xx hci. I made some investigations, basing on driver from Arabella SW.
The whole thing needs microcode upload and is very flakey from what I recall. In fact I gave up b/c it was not
doing things described in datasheet, so the same case.

-- 
Sincerely, Vitaly
