Message-ID: <3BE7F72A.7050803@drea.dnd.ca>
Date: Tue, 06 Nov 2001 12:43:54 -0200
From: Gavin Hemphill <hemphill@drea.dnd.ca>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Ti Powerbooks and YDL 2.1 - Problems
References: <3BE7D31A.6040902@drea.dnd.ca> <20011106124602.29928@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben:
	No problem, I can mount ISO cd's with the 2.2.19 (yellowdog) kernels
(those were the easiest for me to recover via ftp).  There are NO error
messages relating to ATAPI in dmesg with either the 2.2.19 or 2.4.10
(again yellowdog latest kernel).  I've tried it with your latest rsyncd
last night and have the same problem.  The error message in messages
with all the 2.4.x kernels on the Ti Powerbook only is "cdrom: PID xxxx
must open device O_NONBLOCK!" "open failed".  On the Wallstreet, Pismo,
and G4 tower there are no error messages and the mount succeeds.
	G++

Benjamin Herrenschmidt wrote:

>>	 I'd agree if it were an hfs cdrom. However, what I'm trying to do is
>>mount an ISO9660 cdrom (i.e. mount -t iso9660 /dev/cdrom /mnt/cdrom).
>>Now the same CD rom can be mounted on a Wallstreet, a Pismo, a G4 733
>>(when the superdrive is swapped out for a sony CDROM) all of which are
>>running the same kernel as the Ti Powerbook.  I guess I wasn't clear
>>enough in the description that this issue seems to be strictly related
>>to the Matshita SR-8187.  The other machines were installed from the
>>same install CD's etc.
>>
>
> Ah, ok, sorry, seems we have 2 different problems going on there...
>
> You say the same CD-ROM drive works with a 2.2.x kernel ?
>
> What 2.2.x version exactly ? Do you see any error from the ATAPI
> layer in dmesg ?
>
> Ben.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
