Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 14B06DDFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:03:39 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so58519anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 07:03:32 -0800 (PST)
Message-ID: <fa686aa40801090703m5f411795j890bfa714a128b1e@mail.gmail.com>
Date: Wed, 9 Jan 2008 08:03:31 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: Please pull linux-2.6-virtex.git
In-Reply-To: <87ir23tbgz.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40801082207h24c9b262i55b9756c3c435d7c@mail.gmail.com>
	<20080109063512.1226b979@zod.rchland.ibm.com>
	<87ir23tbgz.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Josh" == Josh Boyer <jwboyer@linux.vnet.ibm.com> writes:
>
>  Josh> On Tue, 8 Jan 2008 23:07:51 -0700
>  Josh> "Grant Likely" <grant.likely@secretlab.ca> wrote:
>
>  >> Josh, here are some Xilinx Virtex changes for 2.6.25:
>  >>
>  >> git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-for-2.6.25
>
>  Josh> Hm..  Seems Peter has some comments on the first one.  Shall I wait for
>  Josh> that to get hashed out?
>
> Yes please.

Gah; teach me to pick up patches right before bed.  I shouldn't have
picked up the ulite console changes patch just yet.  I've dropped it
from the series until I have a chance to rework it.  Sorry.

Here's the new pull request

The following changes since commit 4f43143f9fbbb679c38d2ff99e44d3aaa00d0fe1:
  Paul Mackerras (1):
        Merge branch 'for-2.6.25' of git://git.kernel.org/.../olof/pasemi

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-virtex.git virtex-for-2.6.25

Stephen Neuendorffer (5):
      [POWERPC] Xilinx: update compatible list for interrupt controller
      [POWERPC] Xilinx: Add correct compatible list for device tree
bus bindings.
      [POWERPC] Xilinx: Update booting-without-of.
      [POWERPC] Xilinx: updated device tree compatibility to match
uboot bsp generator.
      [POWERPC] Xilinx uartlite: Section type fixups

 Documentation/powerpc/booting-without-of.txt |   56 +++++++++++++++-----------
 arch/powerpc/boot/serial.c                   |    3 +-
 arch/powerpc/platforms/40x/virtex.c          |   12 +++++-
 arch/powerpc/sysdev/xilinx_intc.c            |    8 +++-
 drivers/serial/uartlite.c                    |    6 +-
 5 files changed, 56 insertions(+), 29 deletions(-)

>
> --
> Bye, Peter Korsgaard
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
