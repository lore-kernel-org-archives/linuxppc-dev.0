Message-ID: <39C8D1CE.1847B996@mpifr-bonn.mpg.de>
Date: Wed, 20 Sep 2000 17:03:42 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: "D.J. Osguthorpe" <djosg@mgu.bath.ac.uk>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CPU Temperature Patch
References: <10009201242.AA11420@mgu.bath.ac.uk> or <11420.10009201242@mgu.bath.ac.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"D.J. Osguthorpe" wrote:
> Here are two patches that appear to fix the cpu_temp function in setup.c.
> They have been applied to a number of Ben Herrenschmidt kernels on a 500 MHz
> Pismo powerbook and print reasonable values when you cat /proc/cpuinfo.

The patch seems to work on my Lombard/333, too... Really great!

> +       /* this set for 500 MHz Pismo - how do we get access to clock?? */

There is, in the same file, around line 319 code to read the clock speed from
the device tree. However, is it really necessary to include the clock speed at
this point? What is the drawback if we just assume 500 MHz (or even the max
value) for every G3 based machine?

Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
