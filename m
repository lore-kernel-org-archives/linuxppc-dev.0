Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710261254r105530d4u2e95d96948030ed7@mail.gmail.com>
Date: Fri, 26 Oct 2007 13:54:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Magnus Hjorth" <mh@omnisys.se>
Subject: Re: problems to boot 2.6.23 kernel on XILINX ppc with 8Mbytes of RAM
In-Reply-To: <47203EF9.1070906@omnisys.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <471FA48B.2020809@free.fr> <47203EF9.1070906@omnisys.se>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/25/07, Magnus Hjorth <mh@omnisys.se> wrote:
> Hello Manu,
>
> Could you try the attached patch to arch/ppc/mm/4xx_mmu.c and see if it
> solves your problem?

Good catch, thanks!

Send you're signed off by line, and I'll for Josh to pick it up.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
