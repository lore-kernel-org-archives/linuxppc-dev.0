Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 95416DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 03:30:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH]: [MPC5200] Add ATA DMA support
Date: Tue, 12 Aug 2008 17:30:41 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB03203B75@is-hdq-exchange.marel.net>
In-Reply-To: <792f5f410808120830v311e0446kc8fddfb97d0b9ea6@mail.gmail.com>
References: <DD39B5C3F4963040ADC9768BE7E430CB03202F4F@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB03203863@is-hdq-exchange.marel.net>
	<792f5f410808111319m20d6e09bi8e9782da1fdd4aab@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB0320387D@is-hdq-exchange.marel.net>
	<792f5f410808111431g8fafba1n3b10468da0d165bf@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203A7B@is-hdq-exchange.marel.net>
	<792f5f410808120643md72e679o39692c4bfa3f285e@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203A94@is-hdq-exchange.marel.net>
	<792f5f410808120730j7b4be4f2n7a40de880178ccca@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03203ADC@is-hdq-exchange.marel.net>
	<792f5f410808120830v311e0446kc8fddfb97d0b9ea6@mail.gmail.com>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: "Tim Yamin" <plasm@roo.me.uk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Tim,

Continuing the discussion on the mailing list ...


Looking at the original patch I don't undestand why you had to duplicate
the bestcomm data structures and functions. The only apparent difference
is that you have a minimal data length of 2 bytes instead of 1. Does
this make any difference as the bd_size will be filled with the correct
length value anyway ?

Moreover what is the difference between bcom_submit_next_buffer() and
bcom_submit_next_buffer2() ? The same with bcom_retrieve_buffer() and
bcom_retrieve_buffer2(). Why are these functions implemented unequally ?


Best regards,

Daniel Schnell.
