Return-Path: <bt@oersted.dtu.dk>
Received: from server.oersted.dtu.dk (oersted1.es.oersted.dtu.dk
	[192.38.72.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4AC6DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Jan 2007 02:26:36 +1100 (EST)
Received: from [192.38.72.144] (btpc.es.oersted.dtu.dk [192.38.72.144])
	by server.oersted.dtu.dk (8.12.11.20060308/8.12.11) with ESMTP id
	l05Ei7vj013553
	for <linuxppc-embedded@ozlabs.org>; Fri, 5 Jan 2007 15:44:10 +0100
Message-ID: <459E63E0.7080005@oersted.dtu.dk>
Date: Fri, 05 Jan 2007 15:42:40 +0100
From: Borislav Tomov <bt@oersted.dtu.dk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: How do I make an ACE file for booting Linux on a FX60?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Hi,
I am trying to compile Linux for ML410 (it worked out on ML403). That 
requires a jtagppc controller in the hardware design, which in turn 
requires the second PPC405 to be included, although it is not used 
otherwise. When I try to make an ACE file from the menu in EDK 
(8.2.02),  I get:
-------------------
In order to generate ace file, you must have:-
- exactly one processor.
- opb_mdm, if using microblaze.
-------------------
Using this command:
"xmd -tcl genace.tcl -jprog -hw implementation/download.bit -elf 
Linux/zImage.elf  -start_address 0x00400000 -target ppc_hw  -ace 
implementation/system.ace"
I get an ACE file, but Linux does not boot from the CF card afterwards. 
The zImage.elf  boots when downloaded with the debugger XMD.
Any suggestions?
  
    Best regards,
       Borislav





 
