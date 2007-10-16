Return-Path: <benh@kernel.crashing.org>
Subject: Re: Merge dtc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18196.20112.728499.256646@cargo.ozlabs.ibm.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
	<18196.20112.728499.256646@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 16:00:55 +1000
Message-Id: <1192514455.19073.27.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You must have missed the thread where various people where complaining
> about how powerpc is the only architecture where they can't build
> kernels without some external tool that they don't have, etc., etc.
> 
> We thought about shipping compiled DTBs for various platforms, but the
> problem there is that they can't be updated with a patch, so whoever
> commits a patch to the relevant .dts would have to remember to run dtc
> and commit the updated .dtb as well, which seems a bit error-prone.
> 
> In the end, dtc isn't all that much code.  We already have several
> other programs that run on the host in the process of making a zImage,
> such as wrapper, hack-coff, and addnote, not to mention the various C
> programs that are part of Kbuild, and unifdef, kallsyms, etc.
> 
> So I think there definitely is a precedent for including dtc.

Note that I just tried to build a 4xx kernel today ... and failed due to
the lack of mkimage ..

Another one that we need to either add to the kernel or make the
building of cuImage's optional.

Ben.
