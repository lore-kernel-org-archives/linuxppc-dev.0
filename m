Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C8CFDCD.6080600@embeddededge.com>
Date: Mon, 11 Mar 2002 13:56:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "barry.fisher" <barry.fisher@seranoa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need SPI support
References: <000801c1c91c$a4e67b00$7d0110ac@Seranoa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


barry.fisher wrote:

> Does anyone know where I might get some code to support Motorola 8260
> Serial Peripheral Interface (SPI) for Linux.

I don't believe there is anything for the 8260.  When I did SPI stuff on
the 8xx it is just buried in others drivers (audio or touch screen). I just
software toggled the bits because the overhead was less than managing
the controller.

The controller set up is trivial, just copy the guts of managing BDs
from something else, like I2C.  The SPI implementations typically have
board specific methods for device selection and devices that may be
sensitive to whether the clock keeps running.  A generic driver is
challenging due to these board variations, but a skeleton driver
would be useful.

Wolfgang, do you have something that isn't checked into BK sources :-)?


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
