Date: Mon, 24 May 2004 12:22:58 +0500 (GMT+0500)
From: Venkatesh Savithri Mahesh <vsmahesh@cdotb.ernet.in>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Query about KERNELLOAD. 
In-Reply-To: <20040524050640.GA2245@mars.ravnborg.org>
Message-ID: <Pine.OSF.4.21.0405241202110.19979-100000@ws9.cdotb.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

  I am a novice, please forgive me if this is very trivial.

  I am trying to run 2.4.16 kernel on a custom 8260 board with 128MB
sdram. I am using the TRACE32 JTAG emulator from Lauterbach.

  I am unable to load with KERNELLOAD=0xc0000000.

  When the KERNELLOAD is changed to some other value, say 0x06000000
kernel gets relocated to 0x0 succesfully but reaches a undef instruction
after a few instuctions after emtering the MMU_init function.


    Please advise me. Thanks for any information.

>> V S Mahesh.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
