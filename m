Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 47A44DDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 01:09:46 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2146013wag
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 08:09:45 -0700 (PDT)
Message-ID: <fa686aa40710150809q25664509sa8a14a22739cdcca@mail.gmail.com>
Date: Mon, 15 Oct 2007 09:09:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH v2 2/7] rheap: Changes config mechanism
In-Reply-To: <47137F41.6000404@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044154.23438.58701.stgit@trillian.cg.shawcable.net>
	<751956FC-6B75-416C-A62A-67915652EA51@kernel.crashing.org>
	<fa686aa40710150655s37d8c7d5ye9122034f768a897@mail.gmail.com>
	<5D5FEAFA-AFB9-4F8D-941E-11686E8992F4@kernel.crashing.org>
	<47137ECD.9020103@freescale.com>
	<4540BB4B-8A7C-4D8F-9BBE-0B6F6DAD4DA3@kernel.crashing.org>
	<47137F41.6000404@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Timur Tabi <timur@freescale.com> wrote:
> Kumar Gala wrote:
>
> >> If you turn on the QE but don't turn on RHEAP, the build will fail.
> >> Do we want to allow that?
> >
> > nope.
>
> Is there any way to force RHEAP to be selected when it's a user-selectable option?

Yes, you just add menu text line after the "bool".  Bestcomm, QE and
others still select it unconditionally.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
