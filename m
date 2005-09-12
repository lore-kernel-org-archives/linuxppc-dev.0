Return-Path: <bwaite@irobot.com>
Received: from irobot.com (unknown [67.130.105.243])
	by ozlabs.org (Postfix) with ESMTP id 62339680F3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Sep 2005 23:18:15 +1000 (EST)
From: Brian Waite <bwaite@irobot.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 12 Sep 2005 08:56:23 -0400
References: <1126287092.21092.14.camel@excalibur.timesys.com>
	<1126292945.21092.26.camel@excalibur.timesys.com>
In-Reply-To: <1126292945.21092.26.camel@excalibur.timesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200509120856.24096.bwaite@irobot.com>
Subject: Re: Marvell MV64360 interrupt question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 09 September 2005 3:09 pm, Walter L. Wimer III wrote:
> Thinking about this some more, I think the cascade mechanism I suggested
> earlier is backwards.  Architecturally, I think it makes more sense to
> define a platform-specific function like boardXYZ_get_irq() in
> boardXYZ_setup.c that knows all of the idiosyncrasies of the board and
> calls whatever standard PIC libraries it needs in order to do the right
> thing.  Then we set ppc_md.get_irq = boardXYZ_get_irq;
>
> I looked around, and lo and behold, the Radstone PPC7D already "stole"
> my idea.  :-)  :-)
>
>
Yes, the syslib case in the general case. You can easily override the 
get_irq() routine for your own platform to match a priority scheme you 
desire. 

Thanks
Brian
