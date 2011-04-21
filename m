Return-Path: <meador_inge@mentor.com>
Message-ID: <4DB084F6.4060103@mentor.com>
Date: Thu, 21 Apr 2011 14:26:46 -0500
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: document the FSL MPIC message register
	binding
References: <1303232375-25014-1-git-send-email-meador_inge@mentor.com>	<1303232375-25014-2-git-send-email-meador_inge@mentor.com>	<20110419125214.560f4b99@schlenkerla.am.freescale.net>	<4DADD3D2.6070805@mentor.com>
	<20110419133336.46d8566f@schlenkerla.am.freescale.net>
In-Reply-To: <20110419133336.46d8566f@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: openmcapi-dev@googlegroups.com,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2011 01:33 PM, Scott Wood wrote:
> On Tue, 19 Apr 2011 13:26:26 -0500
> Meador Inge <meador_inge@mentor.com> wrote:
> 
>> On 04/19/2011 12:52 PM, Scott Wood wrote:
>>> On Tue, 19 Apr 2011 11:59:34 -0500
>>> Meador Inge <meador_inge@mentor.com> wrote:
>>>
>>>>  Aliases are of the form 'msgr-block<n>',
>>>> +    where <n> is an integer specifying the block's number.  Numbers shall start
>>>> +    at 0.
>>>
>>> The hw docs refer to "group A" and "group B", not "block 0" and "block 1".
>>>
>>> Plus, I'd put "mpic-" in the alias name.
>>
>> Are you suggesting that the alias should be called: 'mpic-groupA',
>> 'mpic-groupB', 'mpic-groupC', etc... ?
> 
> I was thinking something like "mpic-msgr-group-a", "mpic-msgr-group-b" --
> though if you want to use numbers instead to more easily map to potential
> APIs, that's OK.
> 

Hmmm ...  In the MPC8572E and P1022DS manuals I don't see the terminology
group used for message registers.  The MPIC global timers on the other hand
do use group A and group B.  I will definitely add the 'mpic-' prefix, but
unless I am looking in the wrong place in the manuals, then I am not so
sure there are MPIC message register groups.  As a side note,
the term "register block" pops up in a few places not related to
message registers.

If you feel like group is a more idiomatic term, I can change it.

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
