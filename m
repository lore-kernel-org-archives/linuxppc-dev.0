Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 04442DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 23:02:47 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2249728wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 06:02:45 -0700 (PDT)
Message-ID: <fa686aa40708280602vc00920do459a087c25b830e1@mail.gmail.com>
Date: Tue, 28 Aug 2007 07:02:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Miroslaw Dach" <miroslaw.dach@psi.ch>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <Pine.LNX.4.44.0708281300570.31877-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708270753u1411796fv698d3b39ee908599@mail.gmail.com>
	<Pine.LNX.4.44.0708281300570.31877-100000@slslc02.psi.ch>
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/28/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> Linux/PPC load: console=ttyUL0,9600 root=/dev/nfs rw
> nfsroot=129.117.144.113:/opt/eldk41/ppc_4xx,tcp
> ip=::::virtex4-mirek:eth0:dhcp panic=1
> Uncompressing Linux...
>
>
> After that system just hangs.
>
> I do not understand why it is possible to run zImage.elf straight from jtag
> but it hangs when started from u-boot.
>
> Is it any fundamental problem with running Linux from u-boot on ML403
> (Virtex-4) boards?

No there isn't.  It should work.  Most likely the kernel did not hang
immediately, but rather the console is not setup correctly.  You need
to halt the processor after the hang and look at __log_buf in memory
(Find the address in System.map).

Cheers,
g.

>
> Best Regards
>
> Mirek
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
