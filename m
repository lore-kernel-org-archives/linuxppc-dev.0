Return-Path: <scottwood@freescale.com>
Message-ID: <46376D74.5010105@freescale.com>
Date: Tue, 01 May 2007 11:40:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Small cleanups to the cuboot bootwrapper code
References: <20070430034202.GB6436@localhost.localdomain>
In-Reply-To: <20070430034202.GB6436@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> This patch makes a few small cleanups to the cuboot code.
> 	- It removes the double layered selection of images, via
> cuboot-plat-y, instead having the cuboot platforms directly select a
> suitable image-y (this changes the name of the final cuboot image from
> plain cuImage to cuImage.<platform>).
> 	- Factors out some code in the wrapper that's potentially
> useful to platforms other than uboot.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
