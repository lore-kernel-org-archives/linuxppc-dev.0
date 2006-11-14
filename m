Return-Path: <kallepokki@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 7C54967CDA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 22:26:34 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id p76so1181182pyb
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 03:26:24 -0800 (PST)
Message-ID: <a425f86c0611140326g2270e758x4619d2a193aade02@mail.gmail.com>
Date: Tue, 14 Nov 2006 13:26:23 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: "Dan Malek" <dan@embeddedalley.com>
Subject: Re: CPM_UART: tcdrain() is broken
In-Reply-To: <3E143C92-0F1E-429C-861A-40566E7EF374@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200611131656.23580.laurent.pinchart@tbox.biz>
	<3E143C92-0F1E-429C-861A-40566E7EF374@embeddedalley.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/13/06, Dan Malek <dan@embeddedalley.com> wrote:
>
> On Nov 13, 2006, at 10:56 AM, Laurent Pinchart wrote:
>
> > There is, however, a problem left. The SCC controllers have a 32-
> > byte FIFO
> > between the buffer descriptors and the wires. cpm_uart_tx_empty()
> > checks if
> > all buffer descriptors have been processed, but doesn't check if
> > the transmit
> > FIFO is actually empty.
>
> There is no way to determine if the hardware FIFO is empty.
> It's buried under the CPM microcode.

One might enable the RTS signal and check if it is asserted to see
what the SCC is doing. Unfortunately, the signal may or may not be
used depending on the board.
