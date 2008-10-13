Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 87DC0DDF0A
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 21:03:31 +1100 (EST)
Date: Mon, 13 Oct 2008 12:03:29 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Floating inputs on unused GPIO pins
In-Reply-To: <200810131156.59477.laurentp@cse-semaphore.com>
Message-ID: <Pine.LNX.4.64.0810131201360.3562@vixen.sonytel.be>
References: <200810131156.59477.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1260299970-1223892209=:3562"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1260299970-1223892209=:3562
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 13 Oct 2008, Laurent Pinchart wrote:
> our hardware engineer asked me to make sure all unused GPIO pins are configured as outputs to avoid floating inputs. He got theory on his side (floating inputs can lead to higher current consumption, metastability or even permanent damage), but I'd like to ask the list for practical feedback.
> 
> I haven't been able to find any mention of floating input protection in the MPC8248 documents. Has anyone here experienced issues with floating inputs in real-life designs ? Do you setup your board with all unused GPIO pins configured as outputs ?

I always thought configurable GPIO pins default to _inputs_ after power-on, so
it's safe to tie them to VCC through a pull-up resistor?
For CMOS, you can tie them to VDD or GND without a resistor.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-1260299970-1223892209=:3562--
