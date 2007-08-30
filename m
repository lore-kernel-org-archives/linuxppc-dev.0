Return-Path: <adgospod@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id BA2B2DDDD5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 22:52:05 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so88857anc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 05:52:04 -0700 (PDT)
Message-ID: <bdfc5d6e0708300552g71a995c9x10f17322613ca9c1@mail.gmail.com>
Date: Thu, 30 Aug 2007 08:52:03 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
To: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
Subject: Re: Network is blocked till ping is issued
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EA1869B@aquib01a>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070830010752.0ca3d309.fvoegel@carangul.com>
	<F1F6EC0C8B75034F9E3A79FC85122E8EA1869B@aquib01a>
Cc: "Florian A. Voegel" <fvoegel@carangul.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/30/07, DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it> wrote:
> > sounds to me like it could be a classical ARP problem. Have you
> checked the ARP cache on the non-Linux
> > machine?
>
> But if Linux received the SYN packet of TCP connection, shouldn't the
> Linux machine reply to the source mac address of SYN packet with a
> SYN,ACK packet?
>

No.  You are confusing Ethernet frames and IP packets a little bit.
If a Linux machine receives a SYN from a remote host (not on the same
network) then the Linux machine needs to ARP for the router that is
listed as the default route in the routing table.

If no such default route exists, you will not be able to reach the
remote host.  If the router doesn't reply to your ARP request, you
will not be able to reach the remote host.

Check to make sure you are not having either one of these problems.
