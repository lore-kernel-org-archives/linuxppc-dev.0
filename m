Date: Mon, 2 Jun 2003 13:25:57 -0700
Subject: Re: file system over CF flash
Content-Type: text/plain; charset=ISO-2022-JP; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Magnus Damm <damm@opensource.se>,
	=?ISO-8859-1?B?tqG68dPA?= <nari_dhy@nari-china.com>,
	linuxppc-embedded@lists.linuxppc.org
To: Mark Hatle <fray@mvista.com>
From: Scott Anderson <sanders@mvista.com>
In-Reply-To: <3EDA1076.8010701@mvista.com>
Message-Id: <6B220287-9538-11D7-85A6-000A959CAB7C@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey guys, you missed where he said "IBM MicroDrive"...
On Saturday, May 31, 2003, at 07:46  PM, 丁厚永 wrote:
> There is a CF flash of IBM MicroDrive in xilinx virtex-ii pro eval
> board ML300.
> Can someone tell me what type of fs is used over such kind of flash
> device?

The MicroDrive is actually spinning media and does not have the typical
FLASH concerns that Magnus and Mark pointed out.  In this particular
instance, I believe Xilinx is shipping it with a DOS partition, a Linux
swap partition and an ext2 partition.

    Scott


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
