Subject: Re: how to mount CF device in linux
From: Craig Hollabaugh <craig@hollabaugh.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <001901c34557$315aee60$4a44900a@hydingnb>
References: <001901c34557$315aee60$4a44900a@hydingnb>
Content-Type: text/plain; charset=UTF-8
Date: 08 Jul 2003 09:53:30 -0600
Message-Id: <1057679611.870.22.camel@gibson>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-07-08 at 07:45, 丁厚永 wrote:
>
>     I have a IBM Microdrive CF device which is 1GB.
>     I have joined it with a PC Card Adapter provided by IBM and pluged
> it into a PCMCIA slot in my notebook. Under WIN XP, i can explorer
> the device. How can i find this device under linux(redhat7.3) and
> fdisk,format and create fs with it?

Did the kernel find the device during bootup, use dmesg to look at the
boot messages?

As root, use mount, like

mount -t msdos /dev/xxx /mnt

where xxx is the device the kernel found. msdos might not be correct,
replace msdos with the filesystem type you installed on the card.

Craig

--
------------------------------------------------------------
Dr. Craig Hollabaugh, craig@hollabaugh.com
Author of Embedded Linux: Hardware, Software and Interfacing
www.embeddedlinuxinterfacing.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
