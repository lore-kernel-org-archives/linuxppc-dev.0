Message-ID: <3A679D41.55BED8DC@xilinx.com>
Date: Thu, 18 Jan 2001 17:49:54 -0800
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: Hua Ji <hji@netscreen.com>
CC: "'crossgcc@sources.redhat.com'" <crossgcc@sources.redhat.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hello World and 405GP with my gcc cross compiling.
References: <A33AEFDC2EC0D411851900D0B73EBEF7063E55@NAPA>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Try the following:

${prefix}/bin/${target}-gcc -g -c hello.c
${prefix}/bin/${target}-ld -o hello ${prefix}/${target}/lib/crt0.o hello.o -lc
-lg

- Peter


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
