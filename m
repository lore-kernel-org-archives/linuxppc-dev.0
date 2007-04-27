Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id F05D4DDFD1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 04:41:12 +1000 (EST)
Message-ID: <46324428.7070401@ru.mvista.com>
Date: Fri, 27 Apr 2007 22:42:48 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Charles Krinke <ckrinke@istor.com>
Subject: Re: How do external irq's get mapped?
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F0@MERCURY.inside.istor.com>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F0@MERCURY.inside.istor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Charles Krinke wrote:
> As I understand it, the 8541 and 8555 have 12 external IRQ[0..11], 21
> internal interrupts, and 4 messaging interrupts.

> In looking at the MPC8555ERM.pdf file, which is my main resource, it
> looks like the internal interrupt numbers for the 1st TSEC are 19 for
> transmit and 20 for receive.

> A 'cat /proc/interrupts' shows the 1st TSEC transmit as 93 and the
> receive as 94, so I am puzzled how we get from 19 to 93 for the transmit
> and from 20 to 94 for the receive. Perhaps understanding this will help

   I'd suspect you also have CPM on this SoC (or have CONFIG_CPM* wrongly enabled?).

> me figure out what number to put into the pci_dev structure for external
> IRQ0.

   Could you post your /proc/interrupts?

 > Charles Krinke

WBR, Sergei
