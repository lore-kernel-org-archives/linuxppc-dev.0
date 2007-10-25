Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 258C4DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 01:11:20 +1000 (EST)
Message-ID: <4720B218.80607@grandegger.com>
Date: Thu, 25 Oct 2007 17:11:20 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PCI on Lite5200/Icecube, known issues?
References: <4720A628.8010108@grandegger.com>
	<fa686aa40710250745i57f2a88sbc08478738ee382a@mail.gmail.com>
In-Reply-To: <fa686aa40710250745i57f2a88sbc08478738ee382a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 10/25/07, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Hello,
>>
>> The access to PCI memory space does not to work (I allways read 0xff) on
>> my Icecube-Eval-Board. Are there any known issues/bugs with using the
>> PCI on the Lite5200/Icecube board with 2.6.23? Has it been tested? I
>> realized, that CONFIG_PCI is not set in the default configuration.
> 
> arch/ppc or arch/powerpc?
> 
> I'm not a PCI expert, but I just fired up my Lite5200 with a couple of
> eth adapters plugged in and the devices are usable.  This is a
> 2.6.24-rc1 arch/powerpc kernel.

I'm using a 2.6.23 arch/powerpc kernel. And my eepro100 card does not 
work either:

e100: probe of 0000:00:18.0 failed with error -11

It looks like that 2.6.23 needs some more patches.

Thanks.

Wolfgang.
