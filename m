Return-Path: <achim.machura@berghof.com>
Received: from mail91.messagelabs.com (mail91.messagelabs.com [194.106.220.35])
	by ozlabs.org (Postfix) with SMTP id 4384968926
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 03:01:22 +1100 (EST)
From: "Achim Machura" <achim.machura@berghof.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Date: Thu, 22 Dec 2005 17:01:13 +0100
Message-ID: <002501c60710$efc71270$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <85C67BBD-0072-4B64-A7B1-71871E755B76@kernel.crashing.org>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: AW: AW: Kernel cmdline
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, 

> > I' ve to parse the commandline in a dynamic loaded modul.
> 
> Why would you want to do this.  Anyways, the cmd_line is to exported  
> to modules.  You can provide modules there own params

i want check an argument given by the bootloader via commandline

Achim
