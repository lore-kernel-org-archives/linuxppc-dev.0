Message-ID: <20020111134423.96487.qmail@web9705.mail.yahoo.com>
Date: Fri, 11 Jan 2002 05:44:23 -0800 (PST)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: The "crc error" at star-up of linux on ppc
To: Liu HongXun-a16975 <a16975@motorola.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <01139FC052A0D411900B00508B9535FC04A40E90@ZCH07EXM04.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Crc error? The way I see it, (by the first look) you
have a memory problem. Hardware  I could say...

                             Jim.

--- Liu HongXun-a16975 <a16975@motorola.com> wrote:
>
> Hi, all,
> I met a problem on booting linux on my ppc board.
> When the ramdisk.image.gz is less than 1.5M, the
> boot is OK.
> But when the ramdisk.image.gz exceeds 1.5M, say
> 1.6M, the boot message tells me
> the follow message upon booting:
>
> <5>RAMDISK: Compressed image found at block 0
> <3>crc errorFreeing initrd memory: 4194303k freed
>
> I tried the ramdisk size of 4M and 6M, but got no
> luck.
> what is the reason of such "crc error" message?
> Thanks for your suggestions
>
> Rolf
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
