Return-Path: <prashantsmailcenter@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
 [209.85.215.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B54C71007D2
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Dec 2011 19:05:25 +1100 (EST)
Received: by eaao13 with SMTP id o13so204208eaa.15
 for <linuxppc-dev@ozlabs.org>; Wed, 07 Dec 2011 00:05:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322198727.32635.25.camel@pasglop>
References: <CAD6p20dmksH7YEjijdqLRG06aigaKTpzLPdoL0SCNGD3Ji9d2A@mail.gmail.com>
 <1322198727.32635.25.camel@pasglop>
Date: Wed, 7 Dec 2011 13:35:21 +0530
Message-ID: <CAD6p20chCnh+PN5ekPz20BJQMdTaisb5toLA9rySaYJTeivRfQ@mail.gmail.com>
Subject: Re: ibm_newemac tx problem with jumbo frame enabled
From: Prashant Bhole <prashantsmailcenter@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 25, 2011 at 10:55 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2011-11-18 at 10:33 +0530, Prashant Bhole wrote:
>> Hi,
>> I have been facing problem with ibm_newemac driver (v3.54).
>> The board gets disconnected and can not be pinged in between
>> some heavy network traffic. In my case I am running IOmeter
>> "All-in-One" 8 threads on the iSCSI target. MTU is 4088.
>>
>> I found that after executing emac_full_tx_reset(), the board can
>> be pinged again. Again after some heavy traffic of 5-6 seconds,
>> traffic stops. This can be repeated after full tx reset.
>>
>> Is this a known issue? what could cause this?
>> Any pointers would be greatly appreciated.
>
> Not that I know of. Can you check if any of the error reporting
> registers trip anything ? Could it just be a fifo overflow which we may
> not be handling properly in the driver ?
>
> Cheers,
> Ben.

Still couldn't find anything like fifo overflow...
I noticed one more thing, this problem happens only when mtu size on
the initiator (the other end) is set to 4088, regardless of any mtu size set
for EMAC.


-
Prashant
