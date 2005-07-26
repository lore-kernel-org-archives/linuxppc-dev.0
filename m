Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <CF36C2B8-267D-421C-AA4E-7AE83DCF5172@freescale.com>
References: <CF36C2B8-267D-421C-AA4E-7AE83DCF5172@freescale.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F4AA78A2-3370-406A-83B1-362250AEEC4A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 26 Jul 2005 08:01:36 -0500
To: "Gala Kumar K.-galak" <kumar.gala@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: platform/board removal update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The following board/platforms are currently not building:
> apus
> gemini
> lite5200

lite5200 seems to be running into a pci.h issue between asm-ppc and  
linux.  Sent patch to akpm and gregkh to look at.

> prpmc750
> radstone_ppc7d

I've fixed up prpmc750 (include issue) and radstone_ppc7d (defconfig  
update)

> rpxcllf
> TQM8260

the TQM8260 needs a slightly reorder of includes.  I'll push this  
change today.

All the other systems (apus, gemini, rpxcllf) were more effort than I  
was wanting to deal with.  I'll be sending a patch to list them as  
CONFIG_BROKEN and let the various board maintainers look at fixing  
them up.

- kumar
