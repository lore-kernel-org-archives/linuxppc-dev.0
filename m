Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Message-ID: <46152D90.5070209@smiths-aerospace.com>
Date: Thu, 05 Apr 2007 13:10:40 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH dtc] Implement the -R option and add a -S option.
References: <20070405020433.GA13891@dellserver.lan>
	<20070405161113.GA28063@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070405161113.GA28063@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org, jdl@jdl.com, Jerry Van Baren <gvb.uboot@gmail.com>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Wed, Apr 04, 2007 at 10:04:33PM -0400, Jerry Van Baren wrote:
>> Implement the -R <number> option to add memory reserve slots.
>> Add a -S <size> option makes the blob at least this number of bytes.
> 
> Wouldn't it be better to just specify the amount of extra space, instead
> of the minimum total space?  That way, you only need to know what you
> intend to add, not how much is already there.
> 
> -Scott

I thought briefly about this, but decided to implement a fixed size so 
that someone could allocate, say, 8K of memory in their memory map 
(likely flash) and know their blob would fit.

Maybe we need a little -s option to say "add -s bytes".

Jon suggested a --stats option to print out the important statistics. 
That would also be a good enhancement.

gvb
