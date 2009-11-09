Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AD8CD30.6020003@theptrgroup.com>
References: <4AD8CD30.6020003@theptrgroup.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 9 Nov 2009 12:23:05 -0700
Message-ID: <fa686aa40911091123i6909ec8cme8dfc132d544eab5@mail.gmail.com>
Subject: Re: c67x00 with mpc85xx
To: Jeff Angielski <jeff@theptrgroup.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joel Lord <Lord@assurtech.com>, Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 16, 2009 at 12:44 PM, Jeff Angielski <jeff@theptrgroup.com> wrote:
>
> We are using the Cypress USB Host (CY7C67300) with a Freescale MPC8544 and
> can only get it to work if we add a delay after writing to the hardware
> registers through the HPI.
>
> We tried playing with the SCY settings in the GPCM but nothing helps. It is
> only when we add usecs of delay after our write() functions that the
> hardware works.
>
> The datasheets make no mention of any write-then-read requirements and the
> FAEs are stumped right now.
>
> I was just hoping somebody had some experiencing interfacing this chip to
> the PowerPC and that they could offer some suggestions or ideas.

I've worked with the part attached to the ppc440 inside a Xilinx FPGA.
 Though I ran into many problems, I haven't seen the problem that you
describe.  Sorry.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
