Subject: RE: tftp on ppcboot 1.1.5
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Date: Wed, 15 May 2002 10:14:21 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31937F38@kolkrabbi.flaga.is>
From: =?gb2312?B?S6iicmkgRGF2qKplc3Nvbg==?= <kd@flaga.is>
To: "Arun Dharankar" <ADharankar@ATTBI.Com>,
	"gao xiaoguo" <gaoxg@guoguang.com.cn>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Arun Dharankar [mailto:ADharankar@ATTBI.Com]
> Sent: 15. ma¨ª 2002 09:58
> To: gao xiaoguo; linuxppc-embedded@lists.linuxppc.org
> Subject: Re: tftp on ppcboot 1.1.5
>
>
>
> Following is different in my case (8260ADS board):
> - Load address is 0x500000 (this may not be a problem)
> - ethaddr is 00:11:22:33:44:55 (this prevented tftp in my case
>    with similar symptoms as you describe if I used
>    a1:b2:c3:d4:e5:c6, and I dont know why, and could

First octet must be an even number, i.e. a0:b2:c3:d4:e5:c6 should be o.k.
The last bit in the first octet is the multicast bit.
The first bit in the first octet is the I/G address bit (Individual /Group) and
signifies if the OUI (first half of the MAC address) is universal (set to 0) or local (set to 1).
The second bit in the first octet must be set to 0.

I believe this has been addressed before on this list.

K.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
