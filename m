Return-Path: <timur@freescale.com>
Message-ID: <471F6C3F.10003@freescale.com>
Date: Wed, 24 Oct 2007 11:01:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>	
	<471E12C7.8020509@freescale.com>	
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>	
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>	
	<471F52ED.10007@freescale.com>	
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>	
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>	
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>	
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>	
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
In-Reply-To: <9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> It makes sense to me, there needs to be some way to trigger loading
> the fabric driver.

Well, you only really two have choices:

1) Probe on the AC97/SSI nodes
2) When the driver initializes, just scan all the nodes in the device tree (no 
probing).

I think option #2 makes the most sense, because option #1 says that your fabric 
driver is really an AC97 driver, which it isn't.

You can try to make the fabric driver into a bus driver, but I think that just 
complicates things.
