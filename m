Message-ID: <3FFF2B00.6@embeddededge.com>
Date: Fri, 09 Jan 2004 17:28:16 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
Cc: fabidi@ultsol.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
References: <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>	 <3FFEEAD9.80308@embeddededge.com>	 <1073677509.10794.14.camel@chuck.arlut.utexas.edu>	 <3FFF276C.4060003@embeddededge.com> <1073686698.3275.10.camel@chuck.arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew S. McClintock wrote:

> That leaves me with one question. When I don't do anything in the init
> section of the bdi2000 except one command which is to remove the L2SRAM
> from the initial MMU page and then I proceed with booting the board
> boots fine. If I halt the board examine the CCSRBAR it has moved from
> the default location.

Hmmmmm....interesting.

> I must be missing something, any ideas?

Maybe I am :-)  I'll experiment some more and see.  I was just
describing my experince.  It could be the boot rom initializes far
enough during the BDI2000 power up delay that by the time the BDI2000
asks the cpu core for the CCSRBAR it has the new one?  I'll ask
Abatron and post the response.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
