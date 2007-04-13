Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id CB03CDDFA8
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 04:58:40 +1000 (EST)
Message-ID: <461FD318.4070102@ru.mvista.com>
Date: Fri, 13 Apr 2007 22:59:36 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 
References: <91308d2b933e4fe8a9618aef8748b878@bga.com>	<1176431001.5764.51.camel@localhost.localdomain>
	<a6845fee0c7e5d306f93d0ed71d46b5a@kernel.crashing.org>
In-Reply-To: <a6845fee0c7e5d306f93d0ed71d46b5a@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olaf Hering <olaf@aepfle.de>, Milton Miller <miltonm@bga.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Segher Boessenkool wrote:
>>>+               if (cb & 0x5) { /* if controller is configured for
>>>pci-native mode for both channels */

>>>The above expression allows 1, 4, or 5 for the masked bits.  I'm
>>>guessing you
>>>wanted to test that equal to either 5 or 0.

>>I think the proper test is ((cb & 5) == 5) but I can't remember for
>>sure..
 
> That is correct if you know for sure the controller
> actually supports native mode, and doesn't have that
> support turned off by some configuration setting;
> otherwise, the test should be ((cb & 0xf) == 0xf).

   "I protest your honor". :-)
   Bits 1 and 3 only indicate that bits 0 and 2 are writeable.
 
MBR, Sergei
