Date: Wed, 22 Mar 2000 14:16:13 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: zzh <david-1z@263.net>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: About rs232 on motorola mpc8260 ads board
In-Reply-To: <38D88437.23494@mta2>
Message-ID: <Pine.LNX.4.21.0003221359490.12443-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

> it works when i send char from 8260,but cannot work in the
> other direction.

Make sure that your communication program ignores the modem lines.
I had this problem with IVT (http://home.wxs.nl/~ruurdb/IVT.HTM).
Try TeraTerm PRO (for Win32) or Minicom (for *X), they are known to be Ok.

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
