Message-ID: <001b01c0feb4$6d9dcb40$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: <karanthk@lycos.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <BEOODLLCEMKDDCAA@mailcity.com>
Subject: Re: Uncompressing......
Date: Wed, 27 Jun 2001 10:54:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Iam using mpc823, Iam able to load the compressed image at 0x00200000, iam
trying to boot through NFS it shows the following message,
>
> Boot
>
> loaded at : 00000000 000141B4
> board data at : 00202344 00202374
> zimage at : 0038A000 0007E0B1
> avail ram : 002141B4 0038A000
>
The above relocate messages seems to be wrong.

Try to link your kernel at 0x400000, this may solve your problem.
Also try to look inside arch/ppc/mbxboot/misc.c=>decompress_kernel()
carefully, where you should relocate your compressed image at proper place.

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
