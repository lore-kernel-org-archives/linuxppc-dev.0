Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by ozlabs.org (Postfix) with ESMTP id 000EEB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 18:14:09 +1100 (EST)
Message-ID: <4E9D2731.4010800@grandegger.com>
Date: Tue, 18 Oct 2011 09:13:53 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v13 0/6] flexcan: Add support for powerpc flexcan
 (freescale p1010)
References: <1313551944-28603-1-git-send-email-holt@sgi.com>
 <16FBAA47-5133-43A1-80CE-C6D63B79FB5D@kernel.crashing.org>
In-Reply-To: <16FBAA47-5133-43A1-80CE-C6D63B79FB5D@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
 socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
 PPC list <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

On 10/18/2011 07:44 AM, Kumar Gala wrote:
> 
> On Aug 16, 2011, at 10:32 PM, Robin Holt wrote:
> 
>> David,
>>
>> The following set of patches have been reviewed by the above parties and
>> all comments have been integrated.  Although the patches stray from the
>> drivers/net/can directory, the diversions are related to changes for
>> the flexcan driver.
>>
>> The patch set is based upon your net-next-2.6 tree's commit 6c37e46.
>>
>> Could you please queue these up for the next appropriate push to Linus'
>> tree?
>>
>> Thanks,
>> Robin Holt
> 
> Robin,
> 
> Do you remember why we went with just 'fsl,p1010-flexcan' as the device tree compatible?  Do we feel the flex can on P1010 isn't the same as on MPC5xxx? or the ARM SoCs?

The MPC5xxx SOCs have a MSCAN controller, which is different to the
Flexcan and handled by another driver. But the Flexcan's  on the
Freescale ARM SOCs are identical and supported by that driver as well
and "fsl,flexcan" would work *perfectly*. Actually Grant instructed use
to be more explicit and use "fsl,p1010-flexcan". Anyway,
"fsl,p1010-flexcan" should work on ARM SOCs if the source frequency is
provided via boot loader or the DTS file. Compatibility was one of our
main concerns.

Wolfgang.
