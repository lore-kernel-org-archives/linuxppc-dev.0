Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC5200 Patches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Wolfgang Denk <wd@denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1069116217.7168.52.camel@gaston>
References: <20031117160250.CD994C5F59@atlas.denx.de>
	 <1069116217.7168.52.camel@gaston>
Content-Type: text/plain
Message-Id: <1069116274.7174.54.camel@gaston>
Mime-Version: 1.0
Date: Tue, 18 Nov 2003 11:44:34 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-11-18 at 11:43, Benjamin Herrenschmidt wrote:
> I only ever got DMA reads to work, DMA writes never kicked the
> BestComm task..

Argh... I hate that evolution bug that when you remove the
signature,  it deletes 2 random lines of text...

So I was asking if you had the IDE DMA working correctly since
I see that you have my code in there.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
