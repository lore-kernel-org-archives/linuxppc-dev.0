Mime-Version: 1.0
Message-Id: <v0421010cb4065c7a4ecd@[192.168.0.1]>
In-Reply-To: <Pine.GSO.4.10.9909160957530.21133-100000@ivy.sonytel.be>
References: <Pine.GSO.4.10.9909160957530.21133-100000@ivy.sonytel.be>
Date: Thu, 16 Sep 1999 00:38:38 -0800
To: Geert Uytterhoeven <geert@sonycom.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 16/9/99 Geert Uytterhoeven wrote:

>Doing it this way, even the raw-blocks LILO stuff can get rid of its main
>disadvantage: since the LILO/MILO part is `static', you don't have to rerun
>LILO when upgrading your kernel, only after installing/upgrading MILO. So
>chances that you screw up are smaller, since MILO knows your FS and can boot
>any old kernel on your disks in an emergency.

in essence replace the second stage LILO (/boot/chain.b) with a more 
robust one, that sounds good to me.



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
