Message-ID: <38036952.43E7B55E@jlc.net>
Date: Tue, 12 Oct 1999 13:01:06 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Grant Carter <gcarter@eng.uct.ac.za>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Help with BSE-IP Board and Linux 2.2.5
References: <3803583E.526DCD2E@eng.uct.ac.za>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Carter wrote:


> ...... Since the user space starts at 0x4000, I
> loaded the zImage there. When I tried to run it, the BSE board froze.


So, I guess it doesn't matter that I write the help file :-)?

If you look at 'embedded_notes' it tells you to load the image
at 0x200000.  The code on the front of the zImage file will uncompress
and load the kernel starting at memory address 0.  You have to allow
a few hundred Kbytes for this to happen, and allocate some working
space for the kernel.

In fact, the explicit commands for the BSE-IP are there......

The image doesn't really care where it is loaded, so long as it is
above about 1.5 Mbytes or so.......



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
