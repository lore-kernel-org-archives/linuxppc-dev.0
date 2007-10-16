Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <18196.20112.728499.256646@cargo.ozlabs.ibm.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
	<18196.20112.728499.256646@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5E3B6FCC-5930-4C76-AB4B-86B35551B9E0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Merge dtc
Date: Tue, 16 Oct 2007 00:50:15 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2007, at 12:39 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Dare I ask why we are including dtc in the kernel source tree?  We
>> don't really have precedence for this and there are users outside of
>> linux for dtc.
>
> You must have missed the thread where various people where complaining
> about how powerpc is the only architecture where they can't build
> kernels without some external tool that they don't have, etc., etc.

I must have missed this thread.

> We thought about shipping compiled DTBs for various platforms, but the
> problem there is that they can't be updated with a patch, so whoever
> commits a patch to the relevant .dts would have to remember to run dtc
> and commit the updated .dtb as well, which seems a bit error-prone.

agreed, would seem .S would have been a better choice than .dtb, but  
I agree the keeping a .dts and .S form insync would be a bit of a pain.

> In the end, dtc isn't all that much code.  We already have several
> other programs that run on the host in the process of making a zImage,
> such as wrapper, hack-coff, and addnote, not to mention the various C
> programs that are part of Kbuild, and unifdef, kallsyms, etc.
>
> So I think there definitely is a precedent for including dtc.

Just out of interest who's complaining?  We don't include mkimage for  
u-boot related builds and I haven't seen any gripes related to that.

- k
