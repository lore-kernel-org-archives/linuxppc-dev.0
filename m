Return-Path: <mlan@cpu.lu>
Received: from smtp-out.coditel.net (smtp-out.coditel.net [212.95.66.33])
	by ozlabs.org (Postfix) with ESMTP id A6B52DDE04
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jan 2007 09:29:14 +1100 (EST)
Date: Thu, 4 Jan 2007 23:00:42 +0100 (CET)
From: Mich Lanners <mlan@cpu.lu>
Subject: Re: [RFC: 2.6 patch] remove the broken VIDEO_PLANB driver
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Adrian Bunk <bunk@stusta.de>
In-Reply-To: <1167946479.5273.18.camel@localhost.localdomain>
Message-ID: <tkrat.5fdfdb1db356c580@cpu.lu>
References: <20070104185323.GF20714@stusta.de>
	<1167946479.5273.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: linuxppc-dev@ozlabs.org, v4l-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org, mchehab@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Adrian, hi Ben,

On   5 Jan, this message from Benjamin Herrenschmidt echoed through
cyberspace:
> On Thu, 2007-01-04 at 19:53 +0100, Adrian Bunk wrote:
>> The VIDEO_PLANB driver:
>> - has been marked as BROKEN for more than two years and
>> - is still marked as BROKEN.
>> 
>> Drivers that had been marked as BROKEN for such a long time seem to
>> be unlikely to be revived in the forseeable future.

I was waiting for this one :-) I have to admit I don't have the time to
work on this anymore, so either Ben can fix something, or I will sadly
add my s-o-b.

>> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> I suppose I could give it a go as I do have a machine with that
> hardware rusting somewhere... Don't remove it right away, I'll have a
> look.

If you need explanations about the code or the hardware, don't hesitate
to ask. Not sure what I still remember, but I still have my old paper
notes.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "
