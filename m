Date: Tue, 15 Jul 2003 16:32:54 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Brian Padalino <bpadalino@perigee.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot on Ebony board
Message-ID: <20030715213254.GA27907@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <5.1.0.14.2.20030715092123.02ef0d20@mail.ebshome.net> <DGEEIPOFGGPOACEFBGGCOEGPCAAA.bpadalino@perigee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DGEEIPOFGGPOACEFBGGCOEGPCAAA.bpadalino@perigee.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 15, 2003 at 02:11:07PM -0400, Brian Padalino wrote:
>
> I am trying to transfer PPCBoot that I had compiled over a tftp session in
> the 440GP 1.18 ROM Monitor (02/11/02) that came on the Ebony board.  Is that
> the wrong method of trying it?  I tried using both serial ports and Kermit
> with Xon/Xoff handshaking, but it just ended up timing out.
>
> I keep getting the error:
>   Loading file "C:\ppc\bootp\boot.img" ...
>   Sending tftp boot request ...
>   Not a valid boot image file
>
> Which stems from an improper magic number at the top of the file to say it's
> a valid boot image.

This is not going to work.  You want to program PPCBoot into flash via a
flash programmer or via JTAG.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
