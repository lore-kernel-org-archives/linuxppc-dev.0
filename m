Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73D5F@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73BF1@corpexc01.corp.networkrobots.com>
	<Pine.LNX.4.62.0711130915480.31003@pademelon.sonytel.be>
	<D83235F0F3C86D4D889D8B9A0DA8C6D7F73D5F@corpexc01.corp.networkrobots.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <72880d6da4c2ccb37ba665e420d26666@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: printk/console_init - baud rate setting
Date: Wed, 14 Nov 2007 12:30:04 +0100
To: "Siva Prasad" <sprasad@bivio.net>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I am getting garbage on the screen. So, I presume this must be some 
> sort
> of baud rate issue. Can some one help me out understand how this baud 
> is
> set for serial drivers? I want to run at 115200.

console=ttyS0,115200

See Documentation/kernel-parameters.txt; depending on exactly what
early console you are using, that one might have it hardcoded.  Have
a look around.


Segher
