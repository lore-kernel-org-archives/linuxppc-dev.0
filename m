Return-Path: <wd@denx.de>
To: Ryan Wilkins <ryan@elevated-networks.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 24 Oct 2004 16:33:44 EDT."
	<002D5C38-25FC-11D9-BA35-0050E4B0DC64@elevated-networks.com>
Date: Sun, 24 Oct 2004 22:45:50 +0200
Sender: wd@denx.de
Message-Id: <20041024204555.C38ECC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.com
Subject: Re: MPC850 and GDB help 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <002D5C38-25FC-11D9-BA35-0050E4B0DC64@elevated-networks.com> you wrote:
> 
> What about running the Linux kernel from ram?  Will I encounter the 
> same difficulties?

No, this is what Linux is designed for.

But this doesn't help you. Before Linux can run, you need  a  working
boot loader to initialize the hardware.

Before you start you should ask yourself if  you  have  all  required
documentation  available.  You will need a detailed hardware descrip-
tion, which documents which pins of the MPC8xx  are  used  for  which
purpose,  what  board control registers, CPLDs etc. are there and how
they are expected to be initialized, etc.

With all the documentation available, you will need to get a thorough
understanding of the hardware. Only then you  should  try  porting  a
boot loader.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Carelessly planned projects take three times longer to complete  than
expected.  Carefully  planned  projects  take  four  times  longer to
complete than expected, mostly  because  the  planners  expect  their
planning to reduce the time it takes.
