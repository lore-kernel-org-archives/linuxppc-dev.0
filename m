Message-ID: <001b01c14cc3$a926a3a0$b480a984@int.serialsystem.com.sg>
From: "Nguyen Trung Thanh" <jari.nguyen@serialsystem.com.sg>
To: "Subodh Nijsure" <SNijsure@SkyStream.com>,
	"'linuxppc-embedded '" <linuxppc-embedded@lists.linuxppc.org>
References: <B25E2E5A003CD311B61E00902778AF2A02637AD2@SERVER1>
Subject: Re: Improving ramdisk uncompression time...
Date: Thu, 4 Oct 2001 18:59:38 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

We can make a specific ramdisk by splitting it into
64KB parts, and let it there...
Everytime, we need to read some thing from ramdisk,
we read from the buffer or decompress a part from
that ramdisk.
It'll save you much time while booting and more than 2MB RAM, as well.

Is it cool?
Jari

----- Original Message -----
From: "Subodh Nijsure" <SNijsure@SkyStream.com>
>
> Hello,
>
> My setup has rather large ramdisk 5MB as the ramdisk contains
> firmware for other boards in the system. In total boot time of
> about 60 seconds, close to 50% is spent in uncompressing the ramdisk.
>
> Has anybody tried building ramdisk with bizp2, what other ideas
> one might consider to "speed up" the boot time particularly uncompressing
> the ramdisk...
>
> /Subodh Nijsure


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
