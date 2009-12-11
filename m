Return-Path: <galak@kernel.crashing.org>
Subject: Re: [RFC:PATCH 00/03] powerpc: Expose BookE debug registers through
	extended ptrace interface
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <200912111807.56262.bauerman@br.ibm.com>
Date: Fri, 11 Dec 2009 14:51:51 -0600
Message-Id: <8017A9F8-7854-466C-97BE-A80C2EE43BFE@kernel.crashing.org>
References: <20091210155709.6697.4635.sendpatchset@norville.austin.ibm.com>
	<F0B42818-1EE1-47EE-B2F3-B7529B2E13C8@kernel.crashing.org>
	<1260498456.4329.8.camel@norville.austin.ibm.com>
	<200912111807.56262.bauerman@br.ibm.com>
To: Thiago Jung Bauermann <bauerman@br.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, David Gibson <dwg@au1.ibm.com>,
	Sergio Durigan Junior <sergiodj@br.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 11, 2009, at 2:07 PM, Thiago Jung Bauermann wrote:

> On Fri 11 Dec 2009 00:27:36 Dave Kleikamp wrote:
>> On Thu, 2009-12-10 at 20:23 -0600, Kumar Gala wrote:
>>> On Dec 10, 2009, at 9:57 AM, Dave Kleikamp wrote:
>>>> #define PPC_DEBUG_FEATURE_INSN_BP_RANGE		0x1
>>>> #define PPC_DEBUG_FEATURE_INSN_BP_MASK		0x2
>>>> #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
>>>> #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
>>>=20
>>> Is GDB smart enough to deal w/no condition_regs?  On some Book-E
>>> devices we have 2 IACs, 2 DACs, and 0 DVCs.  Does it need to be in =
the
>>> features?
>>=20
>> I had discussed it with the gdb team.  I could easily add a feature
>> flag, but it would be equivalent to num_condition_regs > 0.  I don't
>> have a strong opinion either way.
>=20
> The current GDB code we have here uses num_condition_regs > 0 to =
discover if=20
> DVCs are supported, so a PPC_DEBUG_FEATURE constant for that is =
redundant=20
> IMHO.

That's fine, just want to make sure we are ok w/num_condition_regs =3D=3D =
0.

- k=
