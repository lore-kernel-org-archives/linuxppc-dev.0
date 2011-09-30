Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id F099A1007DA
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 16:38:54 +1000 (EST)
Date: Fri, 30 Sep 2011 08:38:42 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: Please pull 'next' branch of 5xxx tree
In-reply-to: <4E85622D.8000700@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4E8563F2.20408@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <4E85622D.8000700@denx.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anatolij Gustschin <agust@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Grant,

Heiko Schocher wrote:
> Hello Grant,
> 
> On Thu, 29 Sep 2011 07:49:07 -0500 Grant wrote:
>> On Sep 29, 2011 4:31 AM, "Anatolij Gustschin" <agust@denx.de> wrote:
>>>> Hi Ben,
>>>>
>>>> please pull another two mpc5xxx patches for next. These patches were
>>>> queued in Grant's 'powerpc/next' branch a while ago, but a pull request
>>>> have never been submitted for them. Thanks!
>>>>
>>>> Anatolij
>>>>
>>>> The following changes since commit 7680057cc4c7d9caada12767831bfd9738dd7b43:
>>>>
>>>>  powerpc: Don't try OPAL takeover on old 970 blades (2011-09-29 17:04:59+1000)
>>>>
>>>> are available in the git repository at:
>>>>  git://git.denx.de/linux-2.6-agust.git next
>>>>
>>>> Grant Likely (1):
>>>>      powerpc/5200: add support for charon board
>> Hmmm, I didn't actually write this patch. It looks like the author credit
>> got screwed up at some point.
> 
> I am not got screwed up, I just waiting for an answer, as I wrote here:
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-August/092040.html:
> "Thanks for your review! I wait for a comment on patch
> http://patchwork.ozlabs.org/patch/91919/ from you and rework this
> 2 patches."
> 
> I just forgot to trigger you ;-)

Sorry, was the wrong board ...

For the charon board I have this info from you:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-May/089852.html
"I did pick them up and they are in my tree.  Actually, I squashed
those two together since there was no reason to have them split apart."

So, I thought its on the right way ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
