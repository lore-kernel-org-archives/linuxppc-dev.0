Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.36])
	by ozlabs.org (Postfix) with ESMTP id 957816883E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 04:20:37 +1100 (EST)
Received: from [192.52.109.152] (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id D17AC28009E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 18:20:34 +0100 (CET)
Message-ID: <438C8E8E.3030306@cpe.fr>
Date: Tue, 29 Nov 2005 18:23:26 +0100
From: Nathael PAJANI <nathael.pajani@cpe.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: USB on MPC8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!


I have to support USB hcd for an Actis board based on a MPC8248 
processor. I already have a 2.6.9 linux kernel running fine on it, and 
actualy have to use it rather than a newer one.
I'm actualy looking for existing or ongoing jobs.


Mike Rapoport:

When you say "I'm running linux 2.6.12.3 with "custom" USB host driver."
Are you speaking of this one: "http://cpm2usb.sourceforge.net./" or another?


Kumar Gala:
On the thread "MPC8555 USB host support" you're asking:
"Also, are you aware of Freescale's driver for this?"

Where is this support located? (which files or directories)


Thanks.


PS: Thanks a lot for people who helped me when porting linux 2.6.13 to 
the Actis board VSBX6560 whith MPC8560 processor. It's finished. (Or at 
least, no bug reports yet :)
How to commit a patch to the main kernel tree?
