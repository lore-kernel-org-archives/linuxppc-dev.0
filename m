From: "Stephen Noftall" <stephenn@lcsaudio.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Using 2_4_devel to build a kernel for the 8240
Date: Thu, 25 Apr 2002 14:40:11 -0700
Message-ID: <002401c1eca1$c8260830$61012ac7@snbeast>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200204252126.QAA11192@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello;

I am using the latest bitkeeper PPC 2_4_devel kernel, and want to configure it
for the 8240.

When I run menuconfig, I can see "Sandpoint X3" and "8260" selections, but no
8240 specific selections.

What options should I select to enable 8240 support? I am guessing "Sandpoint
X3", is this right? The board is a custom 8240, with Ethernet and SCSI PCI
chipsets, but no serial or ISA components. We have previously gotten a 2.3.16
kernel to work on it.

Thanks for any feedback.

Stephen Noftall
LCS


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
