Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 616AC68372
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 04:31:57 +1000 (EST)
Date: Tue, 20 Sep 2005 11:32:57 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Brian Waite <bwaite@irobot.com>
Message-ID: <20050920183257.GD5756@mag.az.mvista.com>
References: <B8561865DB141248943E2376D0E85215014202FE@DHOST001-17.DEX001.intermedia.net>
	<200509201313.48945.bwaite@irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200509201313.48945.bwaite@irobot.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: GT64260_eth (Ethernet) Driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 20, 2005 at 01:13:48PM -0400, Brian Waite wrote:
> On Tuesday 20 September 2005 12:02 pm, Earl Olsen wrote:
> platform using the 64260 chip, besides the eval board, was the cpci690.c. I 
> would look and see ifthis is still a working platform and base your platform 
> code off of that.

The cpci690 is a working platform but it does not use the embedded enet
ctlr because there is no driver.

> > Dieu,
> >
> > You should sync up with Brian Waite (look at CC: list) who has been
> > looking at writing a new enet driver for the 2.6 kernel using the latest
> > bridge support code.  You can get a look at the latest support code by
> > cloning bk://source.mvista.com/linux-2.5-marvell.  
> No. Only use mainline kernel.org for latest support. Nothing else is working 
> 100%. In the kernel.org tree the MPSC driver is working along with the 360 
> ethernet device. 

This is from a very, very old email that is no longer accurate.  It
should be ignored.  This is no tree except the mainline/mm tree and there
is not gt64260 enet driver in the mainline/mm tree (that I know of).

> > Note the the mpsc 
> > driver that's there still isn't working correctly.
> I haven't loked at the 64260 for well over a year since we went to the 64360. 
> The 260 was just too bad in too many respects. I was willing to test the 260 
> code with my old hardware if there was a merged driver and even develop the 
> merged driver, but it became obvious the merged driver was going to be ugly

Ditto.

Mark
