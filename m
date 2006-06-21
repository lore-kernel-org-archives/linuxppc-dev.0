Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 91C2967AA0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 17:55:20 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so1691449ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 00:55:18 -0700 (PDT)
Message-ID: <528646bc0606210055m71277d1fl66dacfa7cd7ed203@mail.gmail.com>
Date: Wed, 21 Jun 2006 01:55:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: filippo.capurso@dave-tech.it
Subject: Re: Linux on Virtex4
In-Reply-To: <4498F1E7.5010900@dave-tech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <821B2170E9E7F04FA38DF7EC21DE48710573FD21@VCAEXCH01.hq.corp.viasat.com>
	<528646bc0606191638j64448168ia19d6a97ab81e648@mail.gmail.com>
	<4498F1E7.5010900@dave-tech.it>
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

On 6/21/06, Filippo Capurso <filippo.capurso@dave-tech.it> wrote:
> Hi Grant,
>
> I'm having some trouble with 2.6.17-rc6 kernel (wich incorporates your
> patches for Xilinx ML403 board) and my ML403 board.
> This is my message about this issue:
>
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-June/023321.html

Yes, I had seen your message; but I'm not an expert on the 4xx mmu.  I
haven't seen that behaviour on my board.

Double check your memory ranges.  Have you given the kernel real RAM?

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
