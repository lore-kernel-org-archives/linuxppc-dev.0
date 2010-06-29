Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100629123843.5f94d477.sfr@canb.auug.org.au>
References: <0bcc23b9-2cbd-4465-b17c-7b3c2dff9fd3@VA3EHSMHS007.ehs.local>
	<20100629123843.5f94d477.sfr@canb.auug.org.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 28 Jun 2010 22:56:14 -0700
Message-ID: <AANLkTikEJluwUSTmG64jgQYAt_8YI7-gVA2iqOPKrM9W@mail.gmail.com>
Subject: Re: Using devices trees on X86
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Simek <monstr@monstr.eu>, microblaze-uclinux@itee.uq.edu.au,
	David Miller <davem@davemloft.net>,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 28, 2010 at 7:38 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Stephen,
>
> On Mon, 28 Jun 2010 10:57:33 -0700 Stephen Neuendorffer <stephen.neuendor=
ffer@xilinx.com> wrote:
>>
>> 2) config OF is currently implemented in the architecture code. =A0This
>> should be non-architecture dependent and selected by the arches that
>> need it.
>>
>> Comments greatly appreciated, in particular if you have
>> likely-to-be-easy-to-get-accepted suggestions for 3), or feel like
>> carefully solving 2) in
>> a way which doesn't bork the existing of-based arches.
>
> See the following patch set. =A0Parts 1, 2 and 3 could be applied to the
> respective architecture trees as well as Grant's tree to aleviate some
> conflict problems. =A0Part 5 could wait until a later time if necessary.
> However, this is relatively trivial, so we could just collect ACKs and
> put it all in Grant's tree and live with any minor pain.
>
> Having OF in more than one Kconfig file should not cause any problems as
> long as they are all the same.

I've got an Ack from David now.  I'll wait for more acks, and then
pull the whole series of 5 into my devicetree-next branch.  It's
certainly less invasive that some of the other changes arch changes
I've taken through my tree.

g.
