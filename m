Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20050915223702.GA322@iram.es>
References: <1126644202.11056.59.camel@cashmere.sps.mot.com>
	<200509140435.21916.arnd@arndb.de>
	<1126705588.14036.10.camel@cashmere.sps.mot.com>
	<17193.22140.962651.122114@cargo.ozlabs.ibm.com>
	<20050915205709.GA31156@iram.es>
	<17193.61187.613745.15444@cargo.ozlabs.ibm.com>
	<20050915223702.GA322@iram.es>
Content-Type: text/plain
Message-Id: <1126881977.17442.77.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 16 Sep 2005 09:46:18 -0500
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH powerpc: Merge asm-ppc*/sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-09-15 at 17:37, Gabriel Paubert wrote:

> > I assume you compile custom kernels for these machines, so you're
> > happy with using config options to remove the code you don't want?
> 
> Yes, and I have no problems with it. 
> 

> > Having the .pmac.text, .prep.text etc. sections lets us remove
> > unneeded code at runtime, but it sounds like that isn't actually the
> > issue for you (i.e. you don't have a need to run the same kernel on
> > both a pmac and a prep).
> 
> Not at all. For example my pmac kernels need usb to boot 
> (literally), the MVME machines have CONFIG_USB off (this 
> saves a lot).
> 
> Now there are other architectures that could be merged,
> an example is PreP/PowerPlus/MVME5100. 
> 
> 	Gabriel

Hi Gabriel,

I am reading this to mean that you then have no issue with
my proposed changes of removing the special handling of
the .pmac, .prep, .chrp, and .openfirmware sections that
really only apply to MULTIPLATFORM built images.

Again, for embedded boards and for custom-built configurations,
this change really should have no impact on your image size.

So, were there other objects I missed?  If not, I will
proceed with a patch to remove these special sections
so that we may merge the sections.h header file better!

Thanks!
jdl
