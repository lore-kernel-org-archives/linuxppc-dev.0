Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: kingseft@samsung.co.kr
Date: Sat, 24 Mar 2001 10:13:10 +0900
Message-Id: <H00002af04b2e173@MHS>
Subject: Flash Device Driver 
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,

 I found Flash Device driver related files in linux-2.4.3-pre3-2001-03-11
 I have Intel TE28F160B3(2MBytes, 16bit port size, bottom boot type) flash memory.

 Question1:
 Can I use my intel flash memory for your flash device driver?
 I got flash vendor id : CFI_VENDOR_INTEL_STANDARD
 so , I modified your code like this.
  } else if ((primary_vendor == CFI_VENDOR_INTEL_SHARP_EXTENDED) ||
           (primary_vendor == CFI_VENDOR_INTEL_STANDARD) ) {
 Is it possible ??

 Question2:
 when kernel booted, I found this messages.
 Found 1x16bit 2MBytes CFI Flash device of type Intel Standard at 0xFFE00000
 registered flash device /dev/flasha (minor 0, 4 partitions)
 and when I got shell prompt. I made like this.
 mknod /dev/flasha c 60 0
 mknod /dev/flasha1 c 60 1
 mknod /dev/flasha2 c 60 2
 mknod /dev/flaaha3 c 60 3
 mknod /dev/flasha4 c 60 4

 I tried like this.
 ls -al >> result.txt
 cat result.txt >> /dev/flasha4
 cat /dev/flasha4
 but I coudn't find my result.txt contents..
 Is it impossible??

 Questions3:
 I read your README but I had a question.
 Where can I find flash_erase ??
 W. Denx wrote flash_erase /dev/flasha start_addr end_addr
 Thanks for any comments and replyings...

 kingseft


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
