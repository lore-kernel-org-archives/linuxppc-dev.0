Return-Path: <timur@freescale.com>
Message-ID: <471F75CD.6080606@freescale.com>
Date: Wed, 24 Oct 2007 11:41:49 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Audio codec device tree entries
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>	
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>	
	<471F52ED.10007@freescale.com>	
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>	
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>	
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>	
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>	
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>	
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>	
	<471F6C3F.10003@freescale.com>
	<fa686aa40710240939p408d3e5bj5daae8afcb5ab77f@mail.gmail.com>
In-Reply-To: <fa686aa40710240939p408d3e5bj5daae8afcb5ab77f@mail.gmail.com>
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

Grant Likely wrote:

> If you need to scan the tree, don't do it when the driver registers,
> do it in the platform code instead.  Otherwise you unconditionally
> incur the penalty of scanning the whole device tree on every system
> that loads the driver, regardless of whether or not the device is
> present.

So your saying that the fabric driver should be embedded in the platform driver?
