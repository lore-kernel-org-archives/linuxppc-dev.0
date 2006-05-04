Return-Path: <jean-marie.teuler@lcp.u-psud.fr>
Received: from smtp1.u-psud.fr (smtp1.u-psud.fr [129.175.33.41])
	by ozlabs.org (Postfix) with ESMTP id C4D0B679F5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 20:57:17 +1000 (EST)
Subject: Re: Impossible to open the root console with 2.6.15
From: Jean-Marie Teuler <jean-marie.teuler@lcp.u-psud.fr>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060503230014.BA748353BE7@atlas.denx.de>
References: <20060503230014.BA748353BE7@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 04 May 2006 12:58:34 +0200
Message-Id: <1146740314.6866.26.camel@khnoum.lcp.u-psud.fr>
Mime-Version: 1.0
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

Dear Wolfgang,

> We do not support Linux 2.6 kernels for MPC8xx systems yet.  For  the
> TQM860L please continue to use ELDK 3.1.1 as shipping with the board.

Sorry for the misunderstanding: as the ELDK 4.0 officially supports
MPC8xx systems (as said in the README.html file), and as it is shipped
with a 2.6 kernel, I have jumped to the conclusion that this kernel was
also supported.

Anyway, my present constatation is that, with the help of the tricks
suggested by Jean-François Simon or Mark Chambers, at least the system
starts correctly... I did not make any further check yet.

Best regards,

Jean-Marie
