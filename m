Date: Wed, 20 Sep 2000 11:04:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CPU Temperature Patch
Message-ID: <20000920110436.C15401@opus.bloom.county>
References: <10009201242.AA11420@mgu.bath.ac.uk> <11420.10009201242@mgu.bath.ac.uk> <39C8D1CE.1847B996@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <39C8D1CE.1847B996@mpifr-bonn.mpg.de>; from ad@mpifr-bonn.mpg.de on Wed, Sep 20, 2000 at 05:03:42PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 20, 2000 at 05:03:42PM +0200, Albrecht Dreﬂ wrote:
>
> "D.J. Osguthorpe" wrote:
> > Here are two patches that appear to fix the cpu_temp function in setup.c.
> > They have been applied to a number of Ben Herrenschmidt kernels on a 500 MHz
> > Pismo powerbook and print reasonable values when you cat /proc/cpuinfo.
>
> The patch seems to work on my Lombard/333, too... Really great!
>
> > +       /* this set for 500 MHz Pismo - how do we get access to clock?? */
>
> There is, in the same file, around line 319 code to read the clock speed from
> the device tree. However, is it really necessary to include the clock speed at
> this point? What is the drawback if we just assume 500 MHz (or even the max
> value) for every G3 based machine?

Why assume when we can do it properly?  Besides, a friend of mine oc'ed his
B&W to 550, so it's possible to have >500Mhz :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
