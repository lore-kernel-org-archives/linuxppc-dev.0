Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKgpk3NnhzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 17:47:42 +1000 (AEST)
Message-ID: <1494056846.25766.420.camel@kernel.crashing.org>
Subject: Re: Is iounmap(NULL) safe or not?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Date: Sat, 06 May 2017 09:47:26 +0200
In-Reply-To: <1494024608-10343-1-git-send-email-khoroshilov@ispras.ru>
References: <1494024608-10343-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-05-06 at 01:50 +0300, Alexey Khoroshilov wrote:
> Could you please clarify if iounmap(NULL) safe or not.
> I guess it would be less errorprone if the answer is architecture independent.

I think it's supposed to be and we should fix ppc.

Cheers,
Ben.
