Message-ID: <40B64254.5040004@ztec.com.br>
Date: Thu, 27 May 2004 16:32:36 -0300
From: iida <iida@ztec.com.br>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: how to use the i2c in mpc5200
References: <40B5F176.2020805@ztec.com.br> <Pine.LNX.4.60.0405270900480.32475@xmission.xmission.com>
In-Reply-To: <Pine.LNX.4.60.0405270900480.32475@xmission.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i2s is anoter i/o , but i read the source of i2c and
i think that the minor number is correct
Thanks for help

linuxppc-embedded@2nerds.com wrote:

> On Thu, 27 May 2004, iida wrote:
>
>> i created the i2c with
>> mknod /dev/i2c c 89 1
>
>
> This is just a hunch, but is that the proper minor device number?  In my
> copy of the kernel sources, in the file arch/ppc/5xxx_io/i2s.c, I see
> this
> definition:
>
> #define I2S_MINOR 242
>
> ...which makes me wonder if "mknod /dev/i2c c 89 242" would work any
> better.  Does your source tree include that same definition?  Is that
> "minor number" the one you need to use with mknod?
>
> I'm a novice at this Linux-on-embedded-PPC stuff, so please forgive me if
> this is useless advice--and please let me know how you resolved the
> problem when you find the "right" answer. :-)
>
> Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
