Subject: Hardhat Linux 2.4.2 on IBM Walnut w/AMC ICE
Date: Wed, 21 Mar 2001 17:05:18 -0500
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C49707F90D@voyager.ops.infiniswitch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
From: "Curry, Diane" <dcurry@infiniswitch.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everyone,
  I'm running Monta Vista's 2.4.2 source release on an IBM rev D Walnut
along with AMC's PowerTap (jtag interface) and MWX-ICE software.  In
order to get breakpoints recognized by the ICE, I had to bracket the
code that changed DBCR0 with #ifdef CONFIG_KGDB and #endif statements.
The symptom was that breakpoints set early in initialization, prior to
the execution of ppc4xx_setup_arch, were hit, but once ppc4xx_setup_arch
set the IDM and TDE bits, breakpoints were no longer hit.  Is this
reasonable? Has anyone had similar issues with other ICE units?  Thanks
in advance, for any help.

Diane Curry
dcurry@infiniswitch.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
