Return-Path: <glikely@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 823F867B1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 05:46:34 +1000 (EST)
Received: by nproxy.gmail.com with SMTP id l24so916715nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 12:46:32 -0700 (PDT)
Message-ID: <528646bc0604111246t5fa92de4n73a43bfb6714b6e@mail.gmail.com>
Date: Tue, 11 Apr 2006 13:46:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Vincent Winstead" <vwinstead@yahoo.com>
Subject: Re: Xilinx Virtex-2 PRO FPGA ppc 405 on ML310 board
In-Reply-To: <20060411125550.52660.qmail@web52002.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20060411125550.52660.qmail@web52002.mail.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/11/06, Vincent Winstead <vwinstead@yahoo.com> wrote:
>
> I'm having a real difficulty trying to get linux onto this board.  So I'm
> finally turning to the community for help.  The only people that have
> documented their approach to putting open source linux onto the ML310 boa=
rd
> have used bitkeeper to download the kernel for the project, but bitkeeper
> isn't used any more is it?  I've been going straight to kernel.org and
> getting kernels from there and crosscompiling them on my machine to be
> transported to the ppc core on the ML310.  Is this wrong?  Is there a pat=
ch
> or some kernel source that I don't know about for PPC?  Thanks!

Are you using 2.4 or 2.6?

Support for the ML300 & ML403 is in the mainline 2.6 git tree.  As
long as you've got an xparameters.h file for your FPGA bitstream,  you
should be able to port a 2.6 kernel really easily.

If you want to use 2.4, you can pull the linuxppc rsync mirror which
has ML300 support in it.

http://www.penguinppc.org/kernel/  (Look at the very bottom of the
page for the RSYNC mirror)

Cheers,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
