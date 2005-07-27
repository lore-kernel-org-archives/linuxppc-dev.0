Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 70F9B67DB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 09:34:29 +1000 (EST)
In-Reply-To: <20050727101502.B1114@cox.net>
References: <20050727101502.B1114@cox.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3965D4DD-1628-4463-890F-106DB5BC6931@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 27 Jul 2005 18:34:23 -0500
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	"Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer
	maintained
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Jul 27, 2005, at 12:15 PM, Matt Porter wrote:

> On Wed, Jul 27, 2005 at 09:27:41AM -0700, Eugene Surovegin wrote:
>
>> On Wed, Jul 27, 2005 at 12:13:23PM -0400, Michael Richardson wrote:
>>
>>> Kumar, I thought that we had some volunteers to take care of some of
>>> those. I know that I still care about ep405, and I'm willing to
>>>
> maintain
>
>>> the code.
>>>
>>
>> Well, it has been almost two months since Kumar asked about
>>
> maintenance
>
>> for this board. Nothing happened since then.
>>
>> Why is it not fixed yet? Please, send a patch which fixes it. This is
>> the _best_ way to keep this board in the tree, not some empty
>> maintenance _promises_.
>>
>
> When we recover our history from the linuxppc-2.4/2.5 trees we can
> show exactly how long it's been since anybody touched ep405.
>
> Quick googling shows that it's been almost 2 years since the last
> mention of ep405 (exluding removal discussions) on linuxppc-embedded.
> Last ep405-related commits are more than 2 years ago.

So we are ok with it being removed.  This seems to be the only board  
port that I removed that has caused any noise.

- kumar
