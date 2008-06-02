Return-Path: <stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Generating a FDT from an MHS file
Date: Mon, 2 Jun 2008 09:19:25 -0700
In-Reply-To: <1212422884.16879.6.camel@Phoebe>
References: <1212422884.16879.6.camel@Phoebe>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Jacob Holladay Poteet" <txtbox@gmail.com>,
	<Linuxppc-dev@ozlabs.org>
Message-ID: <20080602161927.317FEE80051@mail145-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


git.xilinx.com has a gen-mhs-devtree.git repository.  This contains an
EDK BSP called 'fdt' which generates the device tree for an EDK design.
The easiest way to use this is to check it out, and then point the EDK
user repository at the edk_lib directory (under project->project
options->project peripheral repository), which will then allow you to
select 'fdt' under software->software platform settings->OS.

Let me know how things go...

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of Jacob
Holladay Poteet
> Sent: Monday, June 02, 2008 9:08 AM
> To: Linuxppc-dev@ozlabs.org
> Subject: Generating a FDT from an MHS file
> =

> I'm going to be spending most of this week bringing myself up to speed
> on how to use these mhs tools (as part of a larger project on partial
> reconfiguration on Xilinx PPC Virtex boards). For now, can someone
help
> me understand how to run the fdt part of the program? I'd like to
> generate an FDT from an MHS file.
> =

>  I'm reading as much as I can independently, but I'd definitely
> appreciate some guidance to help me off the ground.
> =

> Thanks,
> Jake Poteet
> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
