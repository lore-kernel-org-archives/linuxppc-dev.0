Return-Path: <Jan.Schneider@honeywell.com>
Received: from az18nt142.honeywell.com (az18nt142.honeywell.com [199.64.7.142])
	by ozlabs.org (Postfix) with ESMTP id 8E3BC2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Dec 2004 01:13:18 +1100 (EST)
Message-ID: <938F1554888BD71194E100B0D0FCD97201AAD7F7@ge51smail2.ge51.honeywell.de>
From: "Schneider, Jan (GE51)" <Jan.Schneider@honeywell.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Thu, 16 Dec 2004 06:44:57 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: saving registers on task switch
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

I have a MPC855t and using the Kernel 2.4.18.
I want to make some changes in the kernel to use the MPC855's Debug
Registers.
Where is the part in the sources where the registers of one process are
being saved on the stack? 
Is it possible to add there the DebugRegisters?

thank you for any suggestions

Jan
