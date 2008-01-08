Return-Path: <Simon.Richter@hogyros.de>
Message-ID: <4783A4FE.6060900@hogyros.de>
Date: Tue, 08 Jan 2008 17:29:50 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: Generic MMC-over-SPI binding?
References: <47838708.5050008@hogyros.de>
	<20080108161120.GC3177@pengutronix.de>
In-Reply-To: <20080108161120.GC3177@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Robert Schwebel wrote:

> Or is your question how to express this in the device tree?

This. As far as I can see, using the device tree for this is currently 
unsupported, and everyone who uses the mmc-spi driver just creates a 
platform device in the board startup code, which strikes me as somewhat 
redundant, so I think it might be good to move it into the device tree 
(after all, it is still a hardware device).

    Simon
