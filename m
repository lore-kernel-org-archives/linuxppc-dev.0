Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2EE11DDEF9
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 22:06:56 +1100 (EST)
Message-ID: <47F2174B.4040004@grandegger.com>
Date: Tue, 01 Apr 2008 13:06:51 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Using FEC on a MPC5200 with default PHY configuration
References: <47F0ACC7.9080709@grandegger.com> <47F0B26A.10801@grandegger.com>
	<fa686aa40803310633w5f7ddbccq6960b38d00e9381d@mail.gmail.com>
In-Reply-To: <fa686aa40803310633w5f7ddbccq6960b38d00e9381d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Mon, Mar 31, 2008 at 3:44 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Wolfgang Grandegger wrote:
>>  > Hello,
>>  >
>>  > is it possible to use the FEC on a MPC5200 with the default hardware PHY
>>  > configuration. I mean running the link with a default speed without
>>  > handling or even touching the PHY like U-Boot does. I removed the PHY
>>  > entries from the DTS file and disabled CONFIG_FEC_MPC52xx_MDIO but it
>>  > did not work.
>>
>>  To be more precise, I want to support a 3-Port managed switch with PHY
>>  from Micrel using the direct switch link.
> 
> I'm actually working on this exact problem at the moment.  I'll get a
> patch out shortly to do so.

Great, if I can help with testing, please let me know.

Wolfgang.
