Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (unknown [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 383F22BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 07:13:40 +1100 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 5159610BBCC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 09:13:39 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id CD95D10BBC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 09:13:38 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0I8F003015B26500@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Thu, 09 Dec 2004 09:13:38 +1300 (NZDT)
Date: Thu, 09 Dec 2004 09:13:37 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
In-reply-to: <s1b6d954.029@EMAIL>
To: MuthuGanesh M <muthuganeshm@myw.ltindia.com>
Message-id: <41B76071.3040704@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=US-ASCII
References: <s1b6d954.029@EMAIL>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: BDI2000 gdb register display
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

MuthuGanesh M wrote:
> What is there in your reg8xx.def?
> 
> Regards,
> Muthuganesh

Many thanks for the reply - I'd forgotten about that file!

I'm using the standard reg860.def file as supplied with the Abatron 
debugger. Sample below:

sp              GPR     1
pc              SPR     26                      ; is SRR0
;
xer             SPR     1
lr              SPR     8
ctr             SPR     9
dsisr           SPR     18
dar             SPR     19
dec             SPR     22
srr0            SPR     26
srr1            SPR     27
;
cmpa            SPR     144
[snip]

I hope this provides sufficient to verify...


-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
