Return-Path: <Simon.Richter@hogyros.de>
Message-ID: <47838708.5050008@hogyros.de>
Date: Tue, 08 Jan 2008 15:22:00 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Generic MMC-over-SPI binding?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

in an embedded system similar to the lite5200 board, there is an MMC 
card socket connected to one of the PSCs. Ideally, I'd like to express 
this fact via the device tree and have the kernel bind the mmc-spi 
driver to the SPI interface, but I cannot find any place where to insert 
this code that I feel comfortable with.

  - It is not a board-specific thing, because any board can just use any 
SPI bus for MMC.

  - The mmc-spi driver appears to be platform independent, so I'm not 
sure OF bindings should be added to it.

  - The generic device tree scanning does not contain any special cases 
yet, so I don't want to add one.

My current thought is to create a new driver that just handles MMC on 
PSCs in SPI mode by gluing all the relevant drivers together, but that 
doesn't seem optimal to me either.

Any ideas?

    Simon
