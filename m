Date: Thu, 7 Mar 2002 08:32:23 -0800 (PST)
From: Adam Wozniak <awozniak@comdev.cc>
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problems with shared memory
In-Reply-To: <3C8762B3.4000201@bluewin.ch>
Message-ID: <Pine.LNX.4.33.0203070831490.16428-100000@rangers.comdev.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 7 Mar 2002, Wolfgang Grandegger wrote:
> David Ashley has reported lately a bug in arch/ppc/mm/ppc_mmu.c (see
> http://lists.linuxppc.org/linuxppc-embedded/200202/msg00307.html),
> which seems to be present in the linuxppc_2_4 tree but not in the
> linuxppc_2_4_devel tree.
>
> Hope it helps,

Thanks so much.  I think that fixed it.  10000+ iterations without problem.

--Adam
--
Adam Wozniak (KG6GZR)   COM DEV Broadband - Digital and Software Systems
awozniak@comdev.cc      805 Aerovista Place, San Luis Obispo, CA 93401
                        http://www.comdev.cc
                        Voice: (805) 544-1089       Fax: (805) 544-2055


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
