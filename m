Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] CELL PPU Oprofile SPU profiling
	updated patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Carl Love <cel@us.ibm.com>
In-Reply-To: <1170721711.5204.44.camel@dyn9047021078.beaverton.ibm.com>
References: <1170721711.5204.44.camel@dyn9047021078.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 06 Feb 2007 11:49:06 +1100
Message-Id: <1170722946.2620.177.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-05 at 16:28 -0800, Carl Love wrote:
> This is the first update to the patch previously posted by Maynard
> Johnson as "PATCH 4/4. Add support to OProfile for profiling CELL".  
> 
> There are still a few items from the comments being discussed
> specifically how to profile the dynamic code for the SPFS context
> switch
> code and how to deal with dynamic code stubs for library support.  Our
> proposal is to assign the samples from the SPFS and dynamic library
> code
> to an anonymous sample bucket.  The support for properly handling the
> symbol extraction in these cases would be deferred to a later SDK.    
> 
> There is also a bug in profiling overlay code that we are
> investigating.
> 
> Subject: Add support to OProfile for profiling Cell BE SPUs
> 
> From: Maynard Johnson <maynardj@us.ibm.com>
> 
> This patch updates the existing arch/powerpc/oprofile/op_model_cell.c
> to add in the SPU profiling capabilities.  In addition, a 'cell'
> subdirectory
> was added to arch/powerpc/oprofile to hold Cell-specific SPU profiling
> code.
> 
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com> 

Patch got mangled. You seem to be using evolution, make sure you use the
"Preformat" style when posting a patch.

Ben.
