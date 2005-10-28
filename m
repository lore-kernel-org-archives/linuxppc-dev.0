Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 1F58D685ED
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 04:44:33 +1000 (EST)
From: Roger Larsson <roger.larsson@norran.net>
To: David Jander <david.jander@protonic.nl>
Date: Fri, 28 Oct 2005 20:44:43 +0200
References: <200510280857.44625.david.jander@protonic.nl>
	<200510281136.21575.roger.larsson@norran.net>
	<200510281257.22650.david.jander@protonic.nl>
In-Reply-To: <200510281257.22650.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510282044.43523.roger.larsson@norran.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 28 October 2005 12.57, David Jander wrote:
> They are just integers with fixed start values. These are in the loop, so
> it's not an empty loop and hopefully the compiler won't out-optimize it so
> easily (that is of course without specifying any optimization flags).
> Please don't tell me it's a lousy benchmark, because I already know that!
> Be it as lousy as it is, I shouldn't get _those_ results IMHO.
>
> I have downloaded nbench (hopefully a more serious benchmark for raw
> computing power), and the results are as follows (I deliberately excluded
> tests that don't make sense (ie. use FP)):
>
> Kernel 2.4.25:
>
> TEST                : Iterations/sec.  : Old Index   : New Index
>
>                     :                  : Pentium 90* : AMD K6/233*
>
> --------------------:------------------:-------------:------------
> NUMERIC SORT        :          30.438  :       0.78  :       0.26
> STRING SORT         :          1.5842  :       0.71  :       0.11
> BITFIELD            :      7.9506e+06  :       1.36  :       0.28
> FP EMULATION        :           3.258  :       1.56  :       0.36
> IDEA                :          108.89  :       1.67  :       0.49
>
> Kernel 2.6.14-r5:
>
> TEST                : Iterations/sec.  : Old Index   : New Index
>
>                     :                  : Pentium 90* : AMD K6/233*
>
> --------------------:------------------:-------------:------------
> NUMERIC SORT        :          21.042  :       0.54  :       0.18
> STRING SORT         :         0.88215  :       0.39  :       0.06
> BITFIELD            :      6.0979e+06  :       1.05  :       0.22
> FP EMULATION        :          1.6453  :       0.79  :       0.18
> IDEA                :          110.25  :       1.69  :       0.50
>
>

What about the Pentium 90 and AMD K6? Are those values actual measured
results? By you? If not why do THEY differ between the kernel versions?

Is this a MPC8xx problem - can it be verified on a x86?

/RogerL
