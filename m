Message-ID: <39F57828.84A5F7DF@pop.agri.ch>
Date: Tue, 24 Oct 2000 13:53:12 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
References: <14837.11341.207379.903189@argo.linuxcare.com.au>
			<39F53B02.B3E5CAF4@pop.agri.ch> <14837.27948.882957.344247@argo.linuxcare.com.au>
Content-Type: multipart/mixed;
 boundary="------------584D7A09D1D10CE49E142381"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------584D7A09D1D10CE49E142381
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Paul Mackerras wrote:
>
> Andreas Tobler writes:
>
> > My menuconfig breaks with the msg 'MCmenu36: command not found report it
> > to ......'. On the quick it's not very helpful I know.
> > I also wondered why 'Mac device drivers' is the last entry in the
> > menuconfig, no sound, nor Kernel hacking.
>
> Oops, missed an endmenu in arch/ppc/config.in.  Try rsyncing again
> now.

Yup, make menuconfig works so far. But adbhid.c complains about linux/pmu.h,
adb.h and cuda.h missing. They are there but not in linux, they are in asm.


Build ok, no unresolved....
boots also ;-)

uname -ra:
 Linux wallstreet 2.2.18pre17 #5 Tue Oct 24 13:36:24 CEST 2000 ppc unknown



Thanks
Andreas

BTW, attached my dot.config.
--------------584D7A09D1D10CE49E142381
Content-Type: application/x-gzip;
 name="dot.config.gz"
Content-Disposition: inline;
 filename="dot.config.gz"
Content-Transfer-Encoding: base64

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

--------------584D7A09D1D10CE49E142381--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
