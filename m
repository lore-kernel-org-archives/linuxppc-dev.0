Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17490.42678.793678.267072@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 09:35:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
In-Reply-To: <20060428191124.B202B353DAC@atlas.denx.de>
References: <EA2821E8-FB7E-4DDA-8C18-C659B5483DC2@kernel.crashing.org>
	<20060428191124.B202B353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk writes:

> > 2. using a u-boot that is ft aware + dtb (boot command in u-boot  
> > takes kernel & dtb images, updates blob and passes to kernel)
> > 3. using a u-boot that is ft aware + built in dtb.
> > 
> > The issue is that for a given system/board you may need to support  
> > multiple or all three.  This raises the question where does the .dts  
> 
> Assuming we had 2., under which circumstances would we need 3. then?

I imagine 3. would be more convenient for users than 2., or at least
it would seem to mean less typing for them.

Paul.
