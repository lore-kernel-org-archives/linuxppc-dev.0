Return-Path: <jgpobox@gmail.com>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id DDE27B7E55
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 07:18:34 +1100 (EST)
Received: by ywh34 with SMTP id 34so1254117ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Mar 2010 12:18:32 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4B8C2114.1030806@pobox.com>
Date: Mon, 01 Mar 2010 15:18:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] pata_mpc52xx: optimizing code size by change of ATA
	timing data types
References: <200912161429.14968.roman.fietze@telemotive.de>
	<fa686aa41002161141v20a06768nbdcdb094293bb5b2@mail.gmail.com>
In-Reply-To: <fa686aa41002161141v20a06768nbdcdb094293bb5b2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2010 02:41 PM, Grant Likely wrote:
> [cc'd linux-kernel, linux-ide and Jeff Garzik]
>
> Hi Roman.
>
> you should use ./scripts/get_maintainer.pl to make sure you're cc'ing
> the right people when posting patches.  You should repost so that Jeff
> has a copy of the patch to pick up (and add my acked-by when you do).
>
> On Wed, Dec 16, 2009 at 6:29 AM, Roman Fietze
> <roman.fietze@telemotive.de>  wrote:
>> Hello Everybody,
>>
>> A totally simple patch that reduces the text size as of the
>> ppc_6xx-size command of pata_mpc52xx by more than 10%, by reducing the
>> rodata size from 0x4a4 to 0x17e bytes. This is simply done by changing
>> the data types of the ATA timing constants.
>
> Acked-by: Grant Likely<grant.likely@secretlab>

I have the ACK, but never saw the requested repost...  req that, please?
