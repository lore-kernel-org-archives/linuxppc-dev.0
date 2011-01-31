Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110131113657.GC13541@zod.rchland.ibm.com>
References: <20110131073918.9058.37628.stgit@localhost6.localdomain6>
	<20110131074502.9058.11473.stgit@localhost6.localdomain6>
	<20110131113657.GC13541@zod.rchland.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 31 Jan 2011 13:20:48 -0700
Message-ID: <AANLkTin5s3xLfhERvBCKN9+4ZoRVEGt7Zq_2XFWwn=TR@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt: Remove obsolete description of powerpc boot
	interface
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sam@ravnborg.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 31, 2011 at 4:36 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wr=
ote:
> On Mon, Jan 31, 2011 at 12:45:05AM -0700, Grant Likely wrote:
>>32 and 64 bit powerpc support has been merged for a while now, but
>>the booting-without-of.txt document still describes 32 bit as not
>>supporting multiplatform, which is no longer true. =A0This patch fixes
>>the documentation.
>>
>>Also remove references to powerpc-specific details outside of section
>>I in preparation to add details for other architectures.
>
> There's a line around 500 that starts:
>
> =A0 =A0 =A0 =A0"The kernel powerpc generic code does..."
>
> Perhaps the powerpc reference should be dropped there?

Done

>
> Also, there are several mentions of "real Open Firmware", which are
> probably just fine, and prom_init(), which are probably arch specific.

The prom_init() reference is just an example, and so I'm okay with it
staying in.  The example is relevant to look at regardless of the
architecture you are working on.  Oh, but I should drop the reference
to every node requiring a "device_type" property.

>
> There is a section that talks about ranges that starts with:
>
> =A0 =A0 =A0 =A0"For a new 64-bit powerpc board, I...".

Fixed.

>
> Section III 5) has all kinds of powerpc specific stuff. =A0CHRP,
> pSeries, PAPR in the root node. =A0The references to Apple machines for
> examples are probably OK, but it shouldn't make PowerPC items as
> explicit requirements.

Right, fixed.

>
> Section III 5e) references a file that doesn't exist:
> arch/ppc64/kernel/setup.c

Fixed

>
> Section V, paragraph 2 references a file that doesn't exist:
> arch/ppc64/kernel/prom.c


>
> Hope that helps you...
>
> josh
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
