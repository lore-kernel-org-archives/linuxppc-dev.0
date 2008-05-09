Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id E67B4DDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 01:20:28 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so359535anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 09 May 2008 08:20:27 -0700 (PDT)
Message-ID: <fa686aa40805090820s66801309j161adfcbc360fc42@mail.gmail.com>
Date: Fri, 9 May 2008 09:20:27 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: Fabri <rider4ever@gmail.com>
Subject: Re: MPC5200b MMC over SPI into PSC6
In-Reply-To: <ed84ed090805090802s177f9d47r4be59b5a47138d2a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <481F4DFD.1000702@libero.it>
	<fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>
	<4821A551.3060205@libero.it>
	<fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>
	<482317E2.7000308@libero.it>
	<fa686aa40805080832l2492c46l400986472e985d9a@mail.gmail.com>
	<ed84ed090805090640w11dcfc57r1303ac4fceb482cb@mail.gmail.com>
	<ed84ed090805090651g65ab474fk13d549e7166c3f1c@mail.gmail.com>
	<fa686aa40805090706q572b44e9n2b39a6808562b2ad@mail.gmail.com>
	<ed84ed090805090802s177f9d47r4be59b5a47138d2a@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Fabio Tosetto <tosettofabio83@libero.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 9, 2008 at 9:02 AM, Fabri <rider4ever@gmail.com> wrote:
> Thanks for the patches, now some more rows are printed after RamDisk loading:
>
>   Verifying Checksum ... OK
>   Loading Ramdisk to 0fe68000, end 0ff49bf2 ... OK
> Memory <- <0x0 0x10000000> (256MB)
> CPU clock-frequency <- 0xbcd3d80 (198MHz)
> CPU timebase-frequency <- 0x1f78a40 (33MHz)
> CPU bus-frequency <- 0x7de2900 (132MHz)
>
> zImage starting: loaded at 0x00400000 (sp: 0x0ff4a958)
> Allocating 0x32d410 bytes for kernel ...
> gunzipping (0x00000000 <- 0x0040d000:0x00730fd4)...done 0x30d150 bytes
> Using loader supplied ramdisk at 0xfe68000-0xff49bf2
> initrd head: 0x1f8b0808
>
> Linux/PowerPC load:
                      ^^^^^^^^^^^^^^^^^^

Doesn't look like you are passing a kernel parameters line.  The
kernel probably is booting, but doesn't know where to output the
console.  Try adding "console=ttyPSC0,115200".

Cheers,
g.

>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
