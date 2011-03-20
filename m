Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C47C2B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Mar 2011 17:25:57 +1100 (EST)
Received: by gwj15 with SMTP id 15so2208850gwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 23:25:53 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <alpine.LSU.2.00.1103192023140.1592@sister.anvils>
References: <alpine.LSU.2.00.1103192023140.1592@sister.anvils>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 20 Mar 2011 00:25:33 -0600
Message-ID: <AANLkTikMbMqSRpt9gCrHgzpJuRCGL7rfLAs6erJL0Qjc@mail.gmail.com>
Subject: Re: powerpc/pci sysdata batch hangs G5 boot
To: Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 19, 2011 at 9:41 PM, Hugh Dickins <hughd@google.com> wrote:
> Hi Grant,
>
> I've been unable to boot mmotm on the G5 for a few weeks; and now that
> the problem has reached Linus, I've bisected and it converges on your:
>
> commit b5d937de0367d26f65b9af1aef5f2c34c1939be0
> =A0 =A0powerpc/pci: Make both ppc32 and ppc64 use sysdata for pci_control=
ler

Hi Hugh,

Thanks for the testing.  I don't have access to a G5 unfortunately.
Are you able to capture the good/bad console output and send it to me?
 A digital photo would be fine if you can't grab the raw text.  Add
#define DEBUG to the top of arch/powerpc/kernel/pci-common.c above the
#includes too if you don't mind.

I'm investigating on my end.  I suspect that I've messed up retrieval
of the hose pointer.

Thanks,
g.
