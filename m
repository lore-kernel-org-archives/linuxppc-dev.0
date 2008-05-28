Return-Path: <rodolfo@lesc.ufc.br>
Received: from lesc0.lesc.ufc.br (unknown [200.17.37.126])
	by ozlabs.org (Postfix) with ESMTP id DE3CCDDF77
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 04:05:08 +1000 (EST)
MIME-Version: 1.0
Date: Wed, 28 May 2008 15:05:04 -0300
From: rodolfo <rodolfo@lesc.ufc.br>
To: John Linn <John.Linn@xilinx.com>
Subject: RE: Cross toolchain for ppc405 (virtex-4)
In-Reply-To: <20080528171751.D545CBD8071@mail116-sin.bigfish.com>
References: <20080528171751.D545CBD8071@mail116-sin.bigfish.com>
Message-ID: <a949fe6be8a76bc2ecfa56313f8e7047@lesc.ufc.br>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-embedded@ozlabs.org, Mirek23 <miroslaw.dach@psi.ch>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jonh,

If I use ml403 (with PPC 405) Did i change the predefined compiler flags
for ppc_4xx? The default value is -mcpu=403. 

On Wed, 28 May 2008 11:16:41 -0600, "John Linn" <John.Linn@xilinx.com>
wrote:
> Hi Miroslaw,
> 
> I'm not sure on what version of gcc and glibc it's using, but I have been
> using ELDK 4.1 from denx.com. There are newer versions.
> 
> Thanks,
> John 
> 
> 
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org on behalf
> of Mirek23
> Sent: Wed 5/28/2008 9:54 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Cross toolchain for ppc405 (virtex-4)
>  
> 
> Hi All,
> 
> I am using for some time the crosstool tool-chain (crosstool-0.43) for
the
> ppc405 of my virtex-4.
> It seems to be that the crosstool was not updated for awhile but the
glibc
> and gcc compiler has changed a bit meanwhile.
> 
> The latest working configuration to build the toolchain for ppc405 is
> gcc-4.1.0-glibc-2.3.6.dat
> Does any body has tried to adapt the crosstools to use for example glibc
> 2.7
> ?
> 
> Another alternative would be to use another tool than crosstool. Could
> somebody recommend something which can refer to newer version of gcc and
> glibc .
> 
> Best Regards
> 
> Miroslaw Dach 
> 
>
