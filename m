Message-ID: <4002C3BB.8060805@embeddededge.com>
Date: Mon, 12 Jan 2004 10:56:43 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>,
	fabidi@ultsol.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: TLB and CSSBAR problems with MPC8540 and BDI2000
References: <704F2B356FCC3E49A909C625BD9E5C4002143D@ultsol01.tewks.ultsol.local>	 <3FFEEAD9.80308@embeddededge.com>	 <1073677509.10794.14.camel@chuck.arlut.utexas.edu>	 <3FFF276C.4060003@embeddededge.com> <1073686698.3275.10.camel@chuck.arlut.utexas.edu> <3FFF2B00.6@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> ..... I'll ask
> Abatron and post the response.

I received their response.  Here it is in my words.

The BDI2000 doesn't care if the CCSRBAR is changed by software.
It uses SPRs for debug control, and if it needs to access anything
in the CCSR space, it will fetch the address from the part.

So, I guess there is something else that is incorrect when we
change the CCSRBAR.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
