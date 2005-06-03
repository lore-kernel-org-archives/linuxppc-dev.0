Return-Path: <dgibson@ozlabs.org>
Date: Fri, 3 Jun 2005 18:19:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-embedded@ozlabs.org,
	u-boot-users <u-boot-users@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc64-dev@ozlabs.org
Message-ID: <20050603081941.GA1458@localhost.localdomain>
References: <1117614390.19020.24.camel@gaston>
	<20050602070918.GI4748@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050602070918.GI4748@localhost.localdomain>
Subject: Re: Booting the linux-ppc64 kernel & flattened device tree v0.4
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 02, 2005 at 05:09:18PM +1000, David Gibson wrote:
> On Wed, Jun 01, 2005 at 06:26:30PM +1000, Benjamin Herrenschmidt wrote:
> > DO NOT REPLY TO ALL LISTS PLEASE ! (and CC me on replies).
> > 
> > Here's the fourth version of my document along with new kernel patches
> > for the new improved flattened format, and the first release of the
> > device-tree "compiler" tool. The patches will be posted as a reply to
> > this email. The compiler, dtc, can be downloaded, the URL is in the
> > document.
> 
> [snip]
> 
> > IV - "dtc", the device tree compiler
> > ====================================
> 
> > 
> > dtc source code can be found at
> > <http://ozlabs.org/~dgibson/dtc/dtc.tar.gz>
> 
> I've just updated the dtc tarball with a new version.  Notable
> changes:
> 	- Corrected comment parsing
> 	- Corrected handling of #address-cells, #size-cells properties
> 	- Input from device tree blobs should actually work now
> 	- Corrected autogeneration of "name" properties in blob/asm
> 	  output version < 0x10
> 	- Added a TODO list

And yet another.  Notable changes:
	- Basic generation of the reserve map in blob output, use -R
	  command line option to leave space for a number of reserve
	  map entries to be filled in by bootloader.
	- Rewrite blob and assembler output to better share code, and
	  produce more readable assembler output.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
