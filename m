Message-ID: <3E835B64.4070103@bluewin.ch>
Date: Thu, 27 Mar 2003 21:13:24 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: luca gambazzi <luca.gambazzi@epfl.ch>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on PowerCore CPCI-3750
References: <1048770148.32275.11.camel@shampoo.epfl.ch> <20030327184853.GE31771@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 03/27/2003 07:48 PM Tom Rini wrote:
> On Thu, Mar 27, 2003 at 02:02:28PM +0100, luca gambazzi wrote:
>
>> i'm swiss student, i'm trying to crosscompile a linux kernel for a Force
>> Computers PowerCore CPCI-3750.
> [snip]
>> so my kernel image is wrong,... to create the kernel image (v2.5 patched
>> for ppc) i've used the make bzImage and then with powerpc-linux-objcopy
>> i've changed the ELF32bit file in a binary data file.
>> what's worng? can somebody tell me where fine documentation?
>
> You should probably be using the 'linuxppc_2_4_devel' tree, see
> http://penguinppc.org/dev/kernel.shtml.  Second, 'bzImage' is an alias

I want to make a comment here. On the web page you mention there is no
clear indication on what kernel should be used for PowerCore CPCI-3750
or other embedded platforms especially it does not explain the
difference between the "linuxppc_2_4" and "linuxppc_2_4_devel" tree:

  linuxppc_2_4        stable branch
  linuxppc_2_4_devel  stable branch testing tree

A bit more explanation would be useful.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
