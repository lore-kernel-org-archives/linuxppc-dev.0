Return-Path: <david.jander@protonic.nl>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 694162BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 22:55:59 +1100 (EST)
Received: from linux.local (linux.local [192.168.1.97])
	by protonic.xs4all.nl (Postfix on SuSE Linux 7.2 (i386)) with ESMTP id
	49140D403B for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jan 2005 12:45:07 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 12 Jan 2005 12:55:55 +0100
References: <43395BE65409D911B9FF00110A9BFFDC9F851C@zwg57exm01.ea.mot.com>
In-Reply-To: <43395BE65409D911B9FF00110A9BFFDC9F851C@zwg57exm01.ea.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501121255.56374.david.jander@protonic.nl>
Subject: Re: MPC8xx: Using SCM/SCC and standard 16C550 Uarts together...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 12 January 2005 10:59, Demke Torsten-atd012 wrote:
> I dont know exactly the state of the DENX kernel, but in the standard
> kernel the 8xx UART driver and the 16550 driver are using the same
> device numbers (TTY_MAJOR) and device names (/dev/ttySx).
> You have to change one of them.

You are right! What now? I cannot go around and change TTY_MAJOR!
Is it true then, that you normally cannot have a mix of non-16550 uarts and 
16550 uarts on the same system, without doing nonstandard things with major 
numbers?
Should maybe arch/ppc/8xx_io/uart.c use another major number?

Greetings,

-- 
David Jander
Protonic Holland.
