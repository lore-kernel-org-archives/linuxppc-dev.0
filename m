Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: IBM405/Linux Cross compiler
Date: Fri, 28 Jun 2002 20:45:18 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEDLDJAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have tried to build a cross compiler for the IBM405 processor under
Linux/x86. After much playing, I have decided that the problem is not a
compiler or linker problem but rather a configuration/installation issue.
The problem that I am having is that there are some 403/405 specific
pneumonics that are not recognized by the assembler. (as installed) The
problem appears to be that the option:

	-mcpu=403		->		-mppc
			should be		-m403

I solved this by modifying the "specs" file.

1. Is this the right solution?  I used the configuration options:

	--target=powerpc-linux --with-cpu=403

2. How do you change the configuration utility so that the correct "specs"
file is generated? This was built using 2.95.3. Inspecting the GCC files, it
appears that 3.0.4 has the same problem.

3. Where can I find documentation on the "specs" file?

TIA


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
