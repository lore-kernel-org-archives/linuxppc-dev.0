Message-ID: <3C095837.6090302@embeddededge.com>
Date: Sat, 01 Dec 2001 17:22:47 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: paulus@samba.org, Ralph Blach <rcblach@us.ibm.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
References: <OF04BCE99E.8AF57CF2-ON85256B14.00425D94@raleigh.ibm.com > <15368.891.368917.13579@argo.ozlabs.ibm.com> <3C0814AC.455D6FEA@mvista.com> <3C084F22.3030505@embeddededge.com> <3C091F3C.7176C145@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:



> If I understand correctly, you are talking only about the configuration
> structure, not the header file structure -- so a different topic than
> what this thread has been.

I'm talking about both.  Yes, I know the configuration has been mostly
changed, but today the ibm4xx.h file includes ibm405gp.h which then
includes walnut.h.  This is totally backward.  The ibm4xx.h file should
include walnut.h, which should include ibm405gp.h, which should include
a core or peripheral definition file if necessary.

The ibm4xx.h file (and the mpc8xx.h file) should be replaced by an
appropriate platform.h file which would remove all of the ifdefs we
currently have in the include lists of the C files and some of the
problems with multiple definitions these ifdefs are in place to solve.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
