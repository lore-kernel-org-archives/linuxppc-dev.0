Return-Path: <jschopp@austin.ibm.com>
Message-ID: <450DCD36.2020606@austin.ibm.com>
Date: Sun, 17 Sep 2006 17:33:26 -0500
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Donald Chiarulli <don@cs.pitt.edu>
Subject: Re: Cell - linux compatibility question
References: <5619A22F-A50E-4FE1-B48B-B7AEE5481542@cs.pitt.edu>
In-Reply-To: <5619A22F-A50E-4FE1-B48B-B7AEE5481542@cs.pitt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc64-dev@ozlabs.org, cell_support@bsc.es,
	Steve Levitan <steve@engr.pitt.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Donald Chiarulli wrote:
> Hello folks..
> 
> We are about to order a 1U dual cell server from Mercury Computer, see:
> 
> http://www.mc.com/products/view/index.cfm?id=96&type=boards
> 
> They are offering a linux (yellow dog) from terra-soft on this  
> platform based on the 2.6.14-1 kernel.  I understand that your kernel  
> (I assume that it is fedora core 5) is built for the blade board that  
> you show on your website.
> 
> Do you know anyone who has experience with porting the Cell GNU  
> toolchain to this platform?
> 
> Any predictions on the relative difficulty?
> 
> Thanks in advance for any input you may be able to provide.

Any powerpc toolchain will work out of the box.  The SPU toolchain isn't mainline fsf yet, 
but I assume terra-soft bundles the SPU gnu toolchain as well.  If not you can get it here:

http://www.bsc.es/projects/deepcomputing/linuxoncell/
