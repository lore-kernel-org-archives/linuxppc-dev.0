Message-ID: <3C88C54E.7040402@bluewin.ch>
Date: Fri, 08 Mar 2002 15:06:06 +0100
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Adam Wozniak <awozniak@comdev.cc>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problems with shared memory
References: <Pine.LNX.4.33.0203070831490.16428-100000@rangers.comdev.cc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Adam Wozniak wrote:

>On Thu, 7 Mar 2002, Wolfgang Grandegger wrote:
>> David Ashley has reported lately a bug in arch/ppc/mm/ppc_mmu.c (see
>> http://lists.linuxppc.org/linuxppc-embedded/200202/msg00307.html),
>> which seems to be present in the linuxppc_2_4 tree but not in the
>> linuxppc_2_4_devel tree.
>>
>> Hope it helps,
>
>Thanks so much.  I think that fixed it.  10000+ iterations without problem.
>
The real thank goes to David who found it.

Well, for me the linuxppc_2_4 tree seems to be less up-to-date. It would
be nice if somebody could give a brief status or even recommandation
on the various trees (linuxppc_2_4, linuxppc_2_4_devel, linuxppc_2_5)
including their future ... or point me to a list where it's already
dicussed.

Thanks,

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
