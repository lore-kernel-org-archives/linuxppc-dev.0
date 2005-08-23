Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.27])
	by ozlabs.org (Postfix) with SMTP id 58650680A4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 15:27:36 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'Wolfgang Denk'" <wd@denx.de>
Date: Tue, 23 Aug 2005 13:26:46 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050822130702.27D5F353D18@atlas.denx.de>
Message-Id: <20050823052736.58650680A4@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux Kernel MTD question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When I want to turn on MTD with TQM8XXL, I can't find it in kernel 2.6.12.3.
I use "MTD\Mapping drivers for chip access\CFI Flash device in physical
memory map", it seems only one partition can be used.


Thanks,
Johnson Cheng


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Wolfgang Denk
Sent: Monday, August 22, 2005 9:07 PM
To: JohnsonCheng
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel MTD question 

In message <20050822104924.214ED429CB@denx.de> you wrote:
> 
> How can I put the Environment variables or configurations in
> 0x00060000-0x00080000, or put User Data in 0x005C0000-0x1000000?
> Use U-boot command? Or....

It is up to you to define a memory map for your flash  device(s)  and
create  appropriate partitions for this map in Linux (and probably in
U-Boot, too, using the new "mtdparts" command).

Then you can use standard commands in U-Boot (erase, cp) and in Linux
(erase_all, cp) to store any data you likein your flash.

It is *your* design. *You* must create it.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The IQ of the group is the lowest IQ of a member of the group divided
by the number of people in the group.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
