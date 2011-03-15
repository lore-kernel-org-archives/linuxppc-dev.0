Return-Path: <fredrickprashanth@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAEA9B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 13:41:24 +1100 (EST)
Received: by bwz10 with SMTP id 10so167301bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Mar 2011 19:41:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTik5OR4qtgyzkqZ=ove5QBzLOjapiZi_3b6Byrsf@mail.gmail.com>
References: <AANLkTik5OR4qtgyzkqZ=ove5QBzLOjapiZi_3b6Byrsf@mail.gmail.com>
Date: Mon, 14 Mar 2011 19:41:19 -0700
Message-ID: <AANLkTi=M0TxvCV6JoPR5wTwCrZEqqNq0=EnMSE89hyNt@mail.gmail.com>
Subject: inconsistent order of notify_die and kgdb/debugger between powerpc
	and x86
From: Fredrick Prashanth John Berchmans <fredrickprashanth@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I see in x86, the die chain notifiers are called first
before going to debugger but in powerpc its the
other way round.
Any reason for this inconsistency?
Because, I wanted to take some action before falling
to debugger in powerpc. Is there any cleaner way to do this which would work
irrespective of the architecture?

Thanks,
Fredrick
