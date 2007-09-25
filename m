Return-Path: <dgibson@ozlabs.org>
Date: Tue, 25 Sep 2007 12:16:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alan Bennett <alan@akb.net>
Subject: Re: Problems compiling Linux for MPC8272ADS
Message-ID: <20070925021638.GH30338@localhost.localdomain>
References: <9A1468054ED2FD40907CC3B2C1871D400106CC90@hermes.versatel.com>
	<bfa0697f0709240946i341739b3n8d5541b30bca8cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bfa0697f0709240946i341739b3n8d5541b30bca8cb@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Manil Gaouar <mgaouar@solacom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 24, 2007 at 10:46:41AM -0600, Alan Bennett wrote:
> I added this to my boot/Makefile near the other mcpu=440 lines.  I
> believe there may be a fix coming?

I believe there is.

> $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=440

It should be -mcpu=405 for Walnut, though.

> $(obj)/4xx.o: BOOTCFLAGS += -mcpu=440
> $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
