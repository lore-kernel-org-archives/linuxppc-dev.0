Date: Thu, 24 Feb 2000 20:12:58 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000225031258.ZM6366@saguaro.lan>
In-Reply-To: Bijendra Singh <bijendra@yahoo.com>
        "GCC PowerPC register conventions  ?" (Feb 24,  4:50pm)
References: <20000225005031.27022.qmail@web106.yahoomail.com>
To: Bijendra Singh <bijendra@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: GCC PowerPC register conventions  ?
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Feb 24,  4:50pm, Bijendra Singh wrote:

> I am looking for information on stack contents
> in a C/C++ procedure call to/from PowerPC(eg. 603e )
> assembly code.
> (1) How to organize data in registers when calling
> a C/C++ procedure from PowerPC assembly ?
> (2) Which register holds return value on return from
> a procedure in C/C++ when a C/C++ proc is called
> from ppc assembly.
> (3) Any references/URLs/docs for programming details.

The following documents will answer your questions:

    http://www.mot.com/SPS/ADC/pps/download/8XX/SVR4abippc.pdf
    http://www.mot.com/SPS/ADC/pps/download/8XX/ppceabi.pdf
    http://www.chips.ibm.com/techlib/products/powerpc/manuals/compiler/cover.html

Kevin

--
Kevin Buettner
kev@primenet.com, kevinb@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
