Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E096E67C7B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 20:11:00 +1100 (EST)
Message-ID: <4577DB56.2000802@grandegger.com>
Date: Thu, 07 Dec 2006 10:13:58 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: How to use the device tree for lite5200
References: <4576E8CC.6050508@grandegger.com>	
	<B1186D1B-C47D-46C3-B928-8FDE4A55363B@kernel.crashing.org>	
	<45771721.1080102@grandegger.com>
	<528646bc0612061511v5bfe5f8di9eb7f160221828da@mail.gmail.com>
In-Reply-To: <528646bc0612061511v5bfe5f8di9eb7f160221828da@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
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
> On 12/6/06, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Great, that worked with the additional "-f" option, as suggested by
>> Grant. Now I can boot the kernel but BESTCOM and FEC support seem still
>> missing. Are there already patches around?
> 
> They are not in mainline as they are undergoing rework; I've got
> working drivers in my tree.  see here:
> 
> http://git.secretlab.ca

I already used one of your trees, but obviously the wrong one. Now it 
works, that's great.

Thanks a lot.

Wolfgang.
